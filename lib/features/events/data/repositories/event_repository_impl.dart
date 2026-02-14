import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final SupabaseClient _client;

  EventRepositoryImpl(this._client);

  @override
  Future<List<Event>> getEvents({int limit = 20, int offset = 0}) async {
    final response = await _client
        .from('events')
        .select()
        .order('date_start', ascending: true)
        .range(offset, offset + limit - 1);

    final events = (response as List)
        .map((json) => Event.fromJson(json))
        .toList();
    return _populateAttendance(events);
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
    return _populateAttendance(events);
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
    return _populateAttendance(events);
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
    return populated.first;
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
          .eq('user_id', userId)
          .maybeSingle();

      if (existing == null) {
        await _client.from('event_participants').insert({
          'event_id': eventId,
          'user_id': userId,
        });
      } else {
        await _client
            .from('event_participants')
            .delete()
            .eq('event_id', eventId)
            .eq('user_id', userId);
      }
    } catch (e) {
      throw Exception('Failed to toggle attendance: $e');
    }
  }

  Future<List<Event>> _populateAttendance(List<Event> events) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null || events.isEmpty) return events;

    final eventIds = events.map((e) => e.id).toList();
    final response = await _client
        .from('event_participants')
        .select('event_id')
        .eq('user_id', userId)
        .filter('event_id', 'in', eventIds);

    final attendingEventIds = (response as List)
        .map((e) => e['event_id'] as String)
        .toSet();

    return events.map((e) {
      return e.copyWith(isAttending: attendingEventIds.contains(e.id));
    }).toList();
  }
}
