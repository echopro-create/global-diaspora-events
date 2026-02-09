import 'package:flutter/material.dart';
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
    try {
      // Включаем связанные таблицы в запрос select
      var query = _supabase
          .from('events')
          .select('*, categories(*), event_tags(tags(*))');

      if (categoryId != null) {
        query = query.eq('category_id', categoryId);
      }

      // Если переданы теги, фильтруем через вложенный запрос или фильтр по связанной таблице
      if (tagIds != null && tagIds.isNotEmpty) {
        query = query.inFilter('event_tags.tag_id', tagIds);
      }

      final response = await query.order('start_time');

      return (response as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      debugPrint(
        'Offline mode: Fetching events failed. Returning dummy data. Error: $e',
      );
      return _getDummyEvents();
    }
  }

  Future<List<Event>> getPromotedEvents() async {
    try {
      final response = await _supabase
          .from('events')
          .select('*, categories(*), event_tags(tags(*))')
          .eq('is_promoted', true)
          .limit(5);
      return (response as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      debugPrint(
        'Offline mode: Fetching promoted events failed. Returning dummy data. Error: $e',
      );
      return _getDummyEvents().take(3).toList();
    }
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

  List<Event> _getDummyEvents() {
    return [
      Event(
        id: '1',
        title: 'Украинский Пикник',
        description: 'Встреча диаспоры в парке',
        categoryId: '1',
        startTime: DateTime.now().add(const Duration(days: 2)),
        location: const LatLng(52.5200, 13.4050),
        address: 'Berlin, Treptower Park',
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
        isPromoted: true,
        tags: [
          Tag(id: '1', name: 'Семья'),
          Tag(id: '2', name: 'Еда'),
        ],
        category: Category(id: '1', name: 'Встречи'),
      ),
      Event(
        id: '2',
        title: 'Концерт Океан Ельзы',
        description: 'Большой концерт в поддержку Украины',
        categoryId: '2',
        startTime: DateTime.now().add(const Duration(days: 5)),
        location: const LatLng(52.5000, 13.4000),
        address: 'Berlin, Mercedes-Benz Arena',
        imageUrl:
            'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4',
        isPromoted: true,
        tags: [Tag(id: '3', name: 'Музыка')],
        category: Category(id: '2', name: 'Культура'),
      ),
      Event(
        id: '3',
        title: 'IT Networking',
        description: 'Встреча IT специалистов',
        categoryId: '3',
        startTime: DateTime.now().add(const Duration(days: 1)),
        location: const LatLng(52.5100, 13.3800),
        address: 'Berlin, Coworking Space',
        imageUrl:
            'https://images.unsplash.com/photo-1515187029135-18ee286d815b',
        isPromoted: false,
        tags: [
          Tag(id: '4', name: 'IT'),
          Tag(id: '5', name: 'Networking'),
        ],
        category: Category(id: '3', name: 'Образование'),
      ),
    ];
  }
}

@riverpod
EventsRepository eventsRepository(Ref ref) {
  return EventsRepository(Supabase.instance.client);
}
