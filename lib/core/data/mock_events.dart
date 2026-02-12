import 'dart:math';

import '../../features/events/domain/entities/event.dart';

/// Мок-данные событий для dev-режима и fallback при недоступности Supabase.
///
/// 10 реальных событий с разнообразными категориями, городами и фото.
class MockEvents {
  static List<Event> get all => _events;

  /// Случайное подмножество для «Featured».
  static List<Event> get featured =>
      _events.where((e) => e.isPromoted).toList();

  /// Фильтр по категории.
  static List<Event> byCategory(String categoryId) =>
      _events.where((e) => e.categoryId == categoryId).toList();

  /// Геопоиск (простой — по радиусу в km).
  static List<Event> nearby({
    required double lat,
    required double lng,
    double radiusKm = 50,
  }) {
    return _events.where((e) {
      if (e.latitude == null || e.longitude == null) return false;
      final distance = _haversineKm(lat, lng, e.latitude!, e.longitude!);
      return distance <= radiusKm;
    }).toList();
  }

  /// Поиск по ID.
  static Event? byId(String id) {
    try {
      return _events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  // ── Haversine formula ───────────────────────────────────────────────
  static double _haversineKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371.0; // Earth radius in km
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return r * c;
  }

  static double _deg2rad(double deg) => deg * (3.141592653589793 / 180);

  // ── Данные ──────────────────────────────────────────────────────────
  static final _now = DateTime.now();

  static final List<Event> _events = [
    Event(
      id: 'mock-001',
      title: 'Georgian Night — Live Folk Music',
      description:
          'An evening of traditional Georgian polyphonic singing and contemporary'
          ' fusion. Featuring the Rustavi Ensemble and special guests from Tbilisi.'
          ' Wine tasting included with every ticket.',
      categoryId: 'concerts',
      dateStart: _now.add(const Duration(days: 3, hours: 19)),
      dateEnd: _now.add(const Duration(days: 3, hours: 23)),
      venueName: 'Kulturbrauerei',
      venueAddress: 'Schönhauser Allee 36, 10435 Berlin',
      latitude: 52.5411,
      longitude: 13.4130,
      imageUrl:
          'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=800',
      isPromoted: true,
      participantsCount: 127,
      tags: ['georgian', 'folk', 'music', 'berlin'],
      createdAt: _now.subtract(const Duration(days: 5)),
    ),
    Event(
      id: 'mock-002',
      title: 'Ukrainian Startup Meetup',
      description:
          'Monthly meetup for Ukrainian tech founders in Warsaw. Pitch sessions,'
          ' networking, and mentorship opportunities. Speakers from Google,'
          ' Grammarly, and Ajax Systems.',
      categoryId: 'business',
      dateStart: _now.add(const Duration(days: 5, hours: 18)),
      dateEnd: _now.add(const Duration(days: 5, hours: 21)),
      venueName: 'Google for Startups Campus',
      venueAddress: 'Plac Konesera 10, 03-736 Warsaw',
      latitude: 52.2560,
      longitude: 21.0480,
      imageUrl:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      isPromoted: true,
      participantsCount: 85,
      tags: ['startup', 'tech', 'ukrainian', 'networking'],
      createdAt: _now.subtract(const Duration(days: 3)),
    ),
    Event(
      id: 'mock-003',
      title: 'Central Asian Food Festival',
      description:
          'Taste the flavors of Kazakhstan, Uzbekistan, Kyrgyzstan, and Tajikistan.'
          ' Master classes in plov and manti preparation. Live dombra performance.',
      categoryId: 'festivals',
      dateStart: _now.add(const Duration(days: 7, hours: 11)),
      dateEnd: _now.add(const Duration(days: 7, hours: 20)),
      venueName: 'Markthalle Neun',
      venueAddress: 'Eisenbahnstraße 42/43, 10997 Berlin',
      latitude: 52.5015,
      longitude: 13.4309,
      imageUrl:
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
      isPromoted: false,
      participantsCount: 230,
      tags: ['food', 'central-asia', 'festival', 'culture'],
      createdAt: _now.subtract(const Duration(days: 10)),
    ),
    Event(
      id: 'mock-004',
      title: 'Armenian Stand-Up Night',
      description:
          'Comedy show featuring Armenian diaspora comedians performing in English'
          ' and Russian. Hosted by comedian Sergey Sargsyan. 18+ event.',
      categoryId: 'stand-up',
      dateStart: _now.add(const Duration(days: 2, hours: 20)),
      dateEnd: _now.add(const Duration(days: 2, hours: 23)),
      venueName: 'Comedy Café Prague',
      venueAddress: 'Vodičkova 36, 110 00 Prague',
      latitude: 50.0813,
      longitude: 14.4246,
      imageUrl:
          'https://images.unsplash.com/photo-1585699324551-f6c309eedeca?w=800',
      isPromoted: false,
      participantsCount: 64,
      tags: ['comedy', 'armenian', 'stand-up', 'prague'],
      createdAt: _now.subtract(const Duration(days: 2)),
    ),
    Event(
      id: 'mock-005',
      title: 'Baltic Kids Art Workshop',
      description:
          'Creative workshop for children ages 5-12 from Lithuanian, Latvian,'
          ' and Estonian families. Painting, clay sculpting, and folk crafts in'
          ' a fun, multilingual environment.',
      categoryId: 'kids',
      dateStart: _now.add(const Duration(days: 10, hours: 10)),
      dateEnd: _now.add(const Duration(days: 10, hours: 14)),
      venueName: 'Børnekulturhus',
      venueAddress: 'Nørrebrogade 17, 2200 Copenhagen',
      latitude: 55.6897,
      longitude: 12.5534,
      imageUrl:
          'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800',
      isPromoted: false,
      participantsCount: 38,
      tags: ['kids', 'art', 'workshop', 'baltic'],
      createdAt: _now.subtract(const Duration(days: 7)),
    ),
    Event(
      id: 'mock-006',
      title: 'Tbilisi Theatre Company — "Pirosmani"',
      description:
          'A stunning theatrical adaptation of the life of Niko Pirosmani,'
          ' the legendary Georgian primitive painter. Performed in Georgian'
          ' with English and German subtitles.',
      categoryId: 'theatre',
      dateStart: _now.add(const Duration(days: 14, hours: 19)),
      dateEnd: _now.add(const Duration(days: 14, hours: 22)),
      venueName: 'Schaubühne',
      venueAddress: 'Kurfürstendamm 153, 10709 Berlin',
      latitude: 52.4976,
      longitude: 13.3035,
      imageUrl:
          'https://images.unsplash.com/photo-1503095396549-807759245b35?w=800',
      isPromoted: true,
      participantsCount: 195,
      tags: ['theatre', 'georgian', 'drama', 'pirosmani'],
      createdAt: _now.subtract(const Duration(days: 14)),
    ),
    Event(
      id: 'mock-007',
      title: 'CIS Futsal Championship',
      description:
          'Annual diaspora futsal tournament featuring teams from 8 countries.'
          ' Categories: men, women, and U-16. Cash prizes and medals.',
      categoryId: 'sports',
      dateStart: _now.add(const Duration(days: 21, hours: 9)),
      dateEnd: _now.add(const Duration(days: 21, hours: 18)),
      venueName: 'SportCity Arena',
      venueAddress: 'Olympisch Stadion 28, 1076 DE Amsterdam',
      latitude: 52.3140,
      longitude: 4.8535,
      imageUrl:
          'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
      isPromoted: false,
      participantsCount: 340,
      tags: ['football', 'sports', 'tournament', 'cis'],
      createdAt: _now.subtract(const Duration(days: 20)),
    ),
    Event(
      id: 'mock-008',
      title: 'Modern Art from Post-Soviet Space',
      description:
          'Group exhibition featuring 12 artists from Ukraine, Georgia, Armenia,'
          ' and Kazakhstan. Curated by Olena Chervonik. Opening night with artist'
          ' talks and wine reception.',
      categoryId: 'art-exhibitions',
      dateStart: _now.add(const Duration(days: 4, hours: 18)),
      dateEnd: _now.add(const Duration(days: 30, hours: 20)),
      venueName: 'Kunsthalle Wien',
      venueAddress: 'Museumsplatz 1, 1070 Vienna',
      latitude: 48.2034,
      longitude: 16.3589,
      imageUrl:
          'https://images.unsplash.com/photo-1531243269054-5ebf6f34081e?w=800',
      isPromoted: false,
      participantsCount: 76,
      tags: ['art', 'exhibition', 'contemporary', 'post-soviet'],
      createdAt: _now.subtract(const Duration(days: 1)),
    ),
    Event(
      id: 'mock-009',
      title: 'Kazakh Music Festival — The Steppe Sound',
      description:
          'A unique fusion of traditional Kazakh music with modern electronic.'
          ' Featuring Dimash Qudaibergen tribute, dombra battles, and DJ sets.'
          ' Outdoor venue with yurt experience.',
      categoryId: 'festivals',
      dateStart: _now.add(const Duration(days: 30, hours: 14)),
      dateEnd: _now.add(const Duration(days: 30, hours: 23)),
      venueName: 'Tempodrom',
      venueAddress: 'Möckernstraße 10, 10963 Berlin',
      latitude: 52.4990,
      longitude: 13.3817,
      imageUrl:
          'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=800',
      isPromoted: true,
      participantsCount: 412,
      tags: ['kazakh', 'music', 'festival', 'electronic'],
      createdAt: _now.subtract(const Duration(days: 15)),
    ),
    Event(
      id: 'mock-010',
      title: 'Belarusian Film Screening — "Crystal"',
      description:
          'Independent Belarusian cinema evening. Screening of award-winning'
          ' documentary "Crystal" followed by Q&A with director Darya Zhuk.'
          ' Free admission, donations welcome.',
      categoryId: 'art-exhibitions',
      dateStart: _now.add(const Duration(days: 6, hours: 19)),
      dateEnd: _now.add(const Duration(days: 6, hours: 22)),
      venueName: 'Kino Iluzjon',
      venueAddress: 'Narbutta 50A, 02-536 Warsaw',
      latitude: 52.2068,
      longitude: 21.0106,
      imageUrl:
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800',
      isPromoted: false,
      participantsCount: 52,
      tags: ['film', 'belarusian', 'cinema', 'documentary'],
      createdAt: _now.subtract(const Duration(days: 4)),
    ),
  ];
}
