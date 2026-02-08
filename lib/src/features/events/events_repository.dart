import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';
import 'package:global_diaspora_events/src/shared/models/category.dart';
import 'package:global_diaspora_events/src/shared/models/tag.dart';

part 'events_repository.g.dart';

class EventsRepository {
  final SupabaseClient _supabase;

  EventsRepository(this._supabase);

  Future<List<Event>> getEvents({
    String? categoryId,
    List<String>? tagIds,
    double? radiusInKm,
    double? lat,
    double? lon,
  }) async {
    // Включаем связанные таблицы в запрос select
    var query = _supabase
        .from('events')
        .select('*, categories(*), event_tags(tags(*))');

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    // Если переданы теги, фильтруем через вложенный запрос или фильтр по связанной таблице
    // Supabase позволяет фильтровать по связанным таблицам через .filter или .eq с путем
    if (tagIds != null && tagIds.isNotEmpty) {
      query = query.inFilter('event_tags.tag_id', tagIds);
    }

    final response = await query.order('start_time');

    return (response as List).map((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event>> getPromotedEvents() async {
    final response = await _supabase
        .from('events')
        .select('*, categories(*), event_tags(tags(*))')
        .eq('is_promoted', true)
        .limit(5);
    return (response as List).map((e) => Event.fromJson(e)).toList();
  }

  Future<List<Category>> getCategories() async {
    final response = await _supabase.from('categories').select().order('name');
    return (response as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Tag>> getTags() async {
    final response = await _supabase.from('tags').select().order('name');
    return (response as List).map((e) => Tag.fromJson(e)).toList();
  }

  Future<void> suggestEvent({
    required String title,
    required String description,
    required String categoryId,
    required DateTime startTime,
    LatLng? location,
    String? address,
    String? imageUrl,
  }) async {
    final data = {
      'title': title,
      'description': description,
      'category_id': int.parse(categoryId),
      'start_time': startTime.toIso8601String(),
      'location': ?location != null
          ? {
              'type': 'Point',
              'coordinates': [location.longitude, location.latitude],
            }
          : null,
      'address': ?address,
      'image_url': ?imageUrl,
      'is_approved': false, // Событие требует модерации
    };

    await _supabase.from('events').insert(data);
  }

  Future<void> joinEvent(String eventId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _supabase.from('event_participants').insert({
      'event_id': eventId,
      'user_id': user.id,
    });
  }

  Future<void> leaveEvent(String eventId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _supabase.from('event_participants').delete().match({
      'event_id': eventId,
      'user_id': user.id,
    });
  }

  Future<Event> getEventById(String id) async {
    final response = await _supabase
        .from('events')
        .select('*, categories(*), event_tags(tags(*))')
        .eq('id', id)
        .single();
    return Event.fromJson(response);
  }
}

@riverpod
EventsRepository eventsRepository(Ref ref) {
  return EventsRepository(Supabase.instance.client);
}
