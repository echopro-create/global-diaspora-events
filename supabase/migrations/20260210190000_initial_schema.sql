-- =================================================================
-- Global Diaspora Events — Initial Database Schema
-- =================================================================
-- PostGIS + 7 tables + RLS + triggers + seed data
-- =================================================================

-- 1. EXTENSIONS
-- -----------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "postgis";

-- 2. TABLES
-- -----------------------------------------------------------------

-- 2.1 Profiles (extends auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
  id            UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name  TEXT,
  avatar_url    TEXT,
  origin_country TEXT,
  current_city  TEXT,
  location      GEOGRAPHY(Point, 4326),
  -- denormalized lat/lng for easy SELECT
  latitude      DOUBLE PRECISION,
  longitude     DOUBLE PRECISION,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.2 Categories
CREATE TABLE IF NOT EXISTS public.categories (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  slug       TEXT NOT NULL UNIQUE,
  icon       TEXT,            -- Material icon name or emoji
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.3 Tags
CREATE TABLE IF NOT EXISTS public.tags (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  slug       TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.4 Events
CREATE TABLE IF NOT EXISTS public.events (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title              TEXT NOT NULL,
  description        TEXT DEFAULT '',
  category_id        UUID NOT NULL REFERENCES public.categories(id) ON DELETE RESTRICT,
  date_start         TIMESTAMPTZ NOT NULL,
  date_end           TIMESTAMPTZ,
  venue_name         TEXT NOT NULL DEFAULT '',
  venue_address      TEXT,
  location           GEOGRAPHY(Point, 4326),
  -- denormalized lat/lng
  latitude           DOUBLE PRECISION,
  longitude          DOUBLE PRECISION,
  image_url          TEXT,
  buy_link           TEXT,
  is_promoted        BOOLEAN NOT NULL DEFAULT false,
  external_id        TEXT,          -- for deduplication from scrapers
  source             TEXT,          -- 'ticketmaster', 'eventim', 'telegram', 'manual'
  participants_count INT NOT NULL DEFAULT 0,
  created_by         UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Unique constraint for external deduplication
CREATE UNIQUE INDEX IF NOT EXISTS idx_events_external_id
  ON public.events(external_id) WHERE external_id IS NOT NULL;

-- Spatial index for geo-queries
CREATE INDEX IF NOT EXISTS idx_events_location
  ON public.events USING GIST(location);

-- Index for date queries
CREATE INDEX IF NOT EXISTS idx_events_date_start
  ON public.events(date_start);

-- 2.5 Event Tags (many-to-many)
CREATE TABLE IF NOT EXISTS public.event_tags (
  event_id UUID NOT NULL REFERENCES public.events(id) ON DELETE CASCADE,
  tag_id   UUID NOT NULL REFERENCES public.tags(id)   ON DELETE CASCADE,
  PRIMARY KEY (event_id, tag_id)
);

-- 2.6 Event Participants ("I'm going")
CREATE TABLE IF NOT EXISTS public.event_participants (
  event_id   UUID NOT NULL REFERENCES public.events(id)   ON DELETE CASCADE,
  profile_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, profile_id)
);

-- 2.7 User Interests
CREATE TABLE IF NOT EXISTS public.user_interests (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  interest_type  TEXT NOT NULL CHECK (interest_type IN ('artist', 'tag', 'category')),
  value          TEXT NOT NULL,       -- artist name, tag slug, or category slug
  weight         REAL NOT NULL DEFAULT 1.0,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_interests_profile
  ON public.user_interests(profile_id);


-- 3. TRIGGERS — auto-update participants_count
-- -----------------------------------------------------------------

-- Function to update count
CREATE OR REPLACE FUNCTION public.update_participants_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE public.events
    SET participants_count = participants_count + 1,
        updated_at = now()
    WHERE id = NEW.event_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE public.events
    SET participants_count = GREATEST(participants_count - 1, 0),
        updated_at = now()
    WHERE id = OLD.event_id;
    RETURN OLD;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger on event_participants
CREATE TRIGGER trigger_update_participants_count
  AFTER INSERT OR DELETE ON public.event_participants
  FOR EACH ROW
  EXECUTE FUNCTION public.update_participants_count();


-- 4. AUTO-CREATE profile on signup
-- -----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();


-- 5. FUNCTION — Nearby events geo-search (PostGIS)
-- -----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.get_nearby_events(
  user_lat    DOUBLE PRECISION,
  user_lng    DOUBLE PRECISION,
  radius_km   DOUBLE PRECISION DEFAULT 50.0,
  result_limit INT DEFAULT 20
)
RETURNS SETOF public.events AS $$
BEGIN
  RETURN QUERY
    SELECT e.*
    FROM public.events e
    WHERE e.location IS NOT NULL
      AND e.date_start >= now()
      AND ST_DWithin(
            e.location,
            ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography,
            radius_km * 1000  -- convert km to meters
          )
    ORDER BY
      e.is_promoted DESC,
      ST_Distance(
        e.location,
        ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography
      )
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 6. ROW LEVEL SECURITY (RLS)
-- -----------------------------------------------------------------

-- Profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Profiles: public read"
  ON public.profiles FOR SELECT
  USING (true);

CREATE POLICY "Profiles: owner insert"
  ON public.profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Profiles: owner update"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Categories (public read-only)
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Categories: public read"
  ON public.categories FOR SELECT
  USING (true);

-- Tags (public read-only)
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Tags: public read"
  ON public.tags FOR SELECT
  USING (true);

-- Events (public read; authenticated users can insert)
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Events: public read"
  ON public.events FOR SELECT
  USING (true);

CREATE POLICY "Events: authenticated insert"
  ON public.events FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Events: creator update"
  ON public.events FOR UPDATE
  USING (auth.uid() = created_by);

-- Event Tags (public read)
ALTER TABLE public.event_tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Event tags: public read"
  ON public.event_tags FOR SELECT
  USING (true);

-- Event Participants
ALTER TABLE public.event_participants ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Participants: public read"
  ON public.event_participants FOR SELECT
  USING (true);

CREATE POLICY "Participants: owner insert"
  ON public.event_participants FOR INSERT
  WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Participants: owner delete"
  ON public.event_participants FOR DELETE
  USING (auth.uid() = profile_id);

-- User Interests
ALTER TABLE public.user_interests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Interests: owner read"
  ON public.user_interests FOR SELECT
  USING (auth.uid() = profile_id);

CREATE POLICY "Interests: owner insert"
  ON public.user_interests FOR INSERT
  WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Interests: owner update"
  ON public.user_interests FOR UPDATE
  USING (auth.uid() = profile_id);

CREATE POLICY "Interests: owner delete"
  ON public.user_interests FOR DELETE
  USING (auth.uid() = profile_id);


-- 7. SEED DATA — Initial categories
-- -----------------------------------------------------------------
INSERT INTO public.categories (name, slug, icon, sort_order) VALUES
  ('Concerts',    'concerts',    '🎵', 1),
  ('Sports',      'sports',      '⚽', 2),
  ('Stand-Up',    'standup',     '😆', 3),
  ('Business',    'business',    '💼', 4),
  ('Kids',        'kids',        '👶', 5),
  ('Theatre',     'theatre',     '🎭', 6),
  ('Festivals',   'festivals',   '🎪', 7),
  ('Art',         'art',         '🎨', 8)
ON CONFLICT (slug) DO NOTHING;

-- Common tags
INSERT INTO public.tags (name, slug) VALUES
  ('football',    'football'),
  ('basketball',  'basketball'),
  ('networking',  'networking'),
  ('comedy',      'comedy'),
  ('live-music',  'live-music'),
  ('electronic',  'electronic'),
  ('hip-hop',     'hip-hop'),
  ('opera',       'opera'),
  ('family',      'family'),
  ('outdoor',     'outdoor'),
  ('free',        'free'),
  ('workshop',    'workshop')
ON CONFLICT (slug) DO NOTHING;
