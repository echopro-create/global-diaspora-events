import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/domain/repositories/event_repository.dart';
import 'package:global_diaspora_events/features/events/domain/models/event_filter.dart';
import 'dart:io';

class EventRepositoryImpl implements EventRepository {
  final SupabaseClient _client;

  EventRepositoryImpl(this._client);

  @override
  Future<List<Event>> getEvents({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    EventFilter? filter,
  }) async {
    var query = _client.from('events').select();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.ilike('title', '%$searchQuery%');
    }

    if (filter != null) {
      if (filter.categoryId != null) {
        query = query.eq('category_id', filter.categoryId!);
      }
      if (filter.date != null) {
        query = query.gte('date_start', filter.date!.toIso8601String());
      }
      if (filter.city != null) {
        query = query.ilike('venue_address', '%${filter.city}%');
      }
    }

    final response = await query
        .order('date_start', ascending: true)
        .range(offset, offset + limit - 1);

    final events = (response as List)
        .map((json) => Event.fromJson(json))
        .toList();
    final withAttendance = await _populateAttendance(events);
    return _populateFavorites(withAttendance);
  }

  @override
  Future<List<Event>> getEventsNearby({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
  }) async {
    // Using simple radius calculation for now, can be replaced with PostGIS rpc if needed
    final response = await _client.rpc(
      'get_events_nearby',
      params: {'lat': latitude, 'long': longitude, 'radius_km': radiusKm},
    );

    final events = (response as List)
        .map((json) => Event.fromJson(json))
        .toList();
    final withAttendance = await _populateAttendance(events);
    return _populateFavorites(withAttendance);
  }

  @override
  Future<List<Event>> getRecommendedEvents() async {
    // In production, this would call a sophisticated matching engine
    // For now, we fetch promoted events or recent ones
    final response = await _client
        .from('events')
        .select()
        .eq('is_promoted', true)
        .order('created_at', ascending: false)
        .limit(10);

    final events = (response as List)
        .map((json) => Event.fromJson(json))
        .toList();
    final withAttendance = await _populateAttendance(events);
    return _populateFavorites(withAttendance);
  }

  @override
  Future<Event> getEventById(String id) async {
    final response = await _client
        .from('events')
        .select()
        .eq('id', id)
        .single();

    final event = Event.fromJson(response);
    final populated = await _populateAttendance([event]);
    final withFavorites = await _populateFavorites(populated);
    return withFavorites.first;
  }

  @override
  Future<void> toggleAttendance(String eventId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Attendance is tracked in a separate table 'event_participants'
    // This method toggles the record
    try {
      final existing = await _client
          .from('event_participants')
          .select()
          .eq('event_id', eventId)
          .eq('profile_id', userId)
          .maybeSingle();

      if (existing == null) {
        await _client.from('event_participants').insert({
          'event_id': eventId,
          'profile_id': userId,
        });
      } else {
        await _client
            .from('event_participants')
            .delete()
            .eq('event_id', eventId)
            .eq('profile_id', userId);
      }
    } catch (e) {
      throw Exception('Failed to toggle attendance: $e');
    }
  }

  @override
  Future<void> toggleFavorite(String eventId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final existing = await _client
          .from('event_favorites')
          .select()
          .eq('event_id', eventId)
          .eq('profile_id', userId)
          .maybeSingle();

      if (existing == null) {
        await _client.from('event_favorites').insert({
          'event_id': eventId,
          'profile_id': userId,
        });
      } else {
        await _client
            .from('event_favorites')
            .delete()
            .eq('event_id', eventId)
            .eq('profile_id', userId);
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<void> createEvent(Event event, File? imageFile) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    String? imageUrl = event.imageUrl;

    if (imageFile != null) {
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}_$userId.$fileExt';
      try {
        await _client.storage.from('events').upload(fileName, imageFile);
        imageUrl = _client.storage.from('events').getPublicUrl(fileName);
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    try {
      // Create a JSON map from the event, but remove 'id' to let DB generate it if needed
      // However, our Event model requires ID. Usually we generate UUID on client or ignore it on insert.
      // Let's assume we ignore the ID passed in the event object for insertion
      final eventData = event.toJson();
      eventData.remove('id');
      eventData.remove('participants_count');
      eventData.remove('is_attending');
      eventData.remove('is_favorite');
      eventData['organizer_id'] = userId; // Ensure organizer is set
      if (imageUrl != null) eventData['image_url'] = imageUrl;

      await _client.from('events').insert(eventData);
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  @override
  Future<List<Event>> getMyEvents() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client
        .from('events')
        .select()
        .eq('organizer_id', userId)
        .order('date_start', ascending: false);

    final events = (response as List)
        .map((json) => Event.fromJson(json))
        .toList();

    // Logic for my events: I definitely attend my own events?
    // Or maybe I just want to see them. Let's populate attendance anyway.
    return _populateAttendance(events);
  }

  @override
  Future<void> updateEvent(Event event, File? imageFile) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    String? imageUrl = event.imageUrl;

    if (imageFile != null) {
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}_$userId.$fileExt';
      try {
        await _client.storage.from('events').upload(fileName, imageFile);
        imageUrl = _client.storage.from('events').getPublicUrl(fileName);
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    try {
      final eventData = event.toJson();
      eventData.remove('id');
      eventData.remove('participants_count');
      eventData.remove('is_attending');
      eventData.remove('is_favorite');
      eventData.remove('organizer_id'); // Don't allow changing organizer
      if (imageUrl != null) eventData['image_url'] = imageUrl;

      await _client
          .from('events')
          .update(eventData)
          .eq('id', event.id)
          .eq('organizer_id', userId);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    try {
      await _client
          .from('events')
          .delete()
          .eq('id', eventId)
          .eq('organizer_id', userId);
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  Future<List<Event>> _populateAttendance(List<Event> events) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null || events.isEmpty) return events;

    final eventIds = events.map((e) => e.id).toList();
    final response = await _client
        .from('event_participants')
        .select('event_id')
        .eq('profile_id', userId)
        .filter('event_id', 'in', eventIds);

    final attendingEventIds = (response as List)
        .map((e) => e['event_id'] as String)
        .toSet();

    return events.map((e) {
      return e.copyWith(isAttending: attendingEventIds.contains(e.id));
    }).toList();
  }

  Future<List<Event>> _populateFavorites(List<Event> events) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null || events.isEmpty) return events;

    final eventIds = events.map((e) => e.id).toList();
    final response = await _client
        .from('event_favorites')
        .select('event_id')
        .eq('profile_id', userId)
        .filter('event_id', 'in', eventIds);

    final favoriteEventIds = (response as List)
        .map((e) => e['event_id'] as String)
        .toSet();

    return events.map((e) {
      return e.copyWith(isFavorite: favoriteEventIds.contains(e.id));
    }).toList();
  }
}
