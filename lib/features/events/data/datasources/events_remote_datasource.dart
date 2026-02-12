import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/event.dart';

/// Remote data source для событий (Supabase).
class EventsRemoteDataSource {
  final SupabaseClient _client;

  EventsRemoteDataSource(this._client);

  /// Получить список событий с фильтрацией.
  Future<List<Event>> getEvents({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    var query = _client
        .from('events')
        .select('*, event_tags(tags(name))')
        .gte('date_start', DateTime.now().toIso8601String())
        .order('is_promoted', ascending: false)
        .order('date_start')
        .range(offset, offset + limit - 1);

    if (categoryId != null) {
      query = _client
          .from('events')
          .select('*, event_tags(tags(name))')
          .eq('category_id', categoryId)
          .gte('date_start', DateTime.now().toIso8601String())
          .order('is_promoted', ascending: false)
          .order('date_start')
          .range(offset, offset + limit - 1);
    }

    final response = await query;
    return response.map((json) => _mapEventWithTags(json)).toList();
  }

  /// Получить события рядом (по координатам, используя RPC-функцию PostGIS).
  Future<List<Event>> getNearbyEvents({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
    int limit = 20,
  }) async {
    final response = await _client.rpc(
      'get_nearby_events',
      params: {
        'user_lat': latitude,
        'user_lng': longitude,
        'radius_km': radiusKm,
        'result_limit': limit,
      },
    );

    return (response as List)
        .map((json) => Event.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Получить одно событие по ID.
  Future<Event> getEventById(String id) async {
    final response = await _client
        .from('events')
        .select('*, event_tags(tags(name))')
        .eq('id', id)
        .single();

    return _mapEventWithTags(response);
  }

  /// Переключить участие в событии ("I'm going" / отмена).
  Future<bool> toggleParticipation({
    required String eventId,
    required String profileId,
  }) async {
    // Проверяем, участвует ли пользователь
    final existing = await _client
        .from('event_participants')
        .select()
        .eq('event_id', eventId)
        .eq('profile_id', profileId)
        .maybeSingle();

    if (existing != null) {
      // Уже участвует → удаляем
      await _client
          .from('event_participants')
          .delete()
          .eq('event_id', eventId)
          .eq('profile_id', profileId);
      return false;
    } else {
      // Не участвует → добавляем
      await _client.from('event_participants').insert({
        'event_id': eventId,
        'profile_id': profileId,
      });
      return true;
    }
  }

  /// Проверить, участвует ли пользователь в событии.
  Future<bool> isParticipating({
    required String eventId,
    required String profileId,
  }) async {
    final response = await _client
        .from('event_participants')
        .select()
        .eq('event_id', eventId)
        .eq('profile_id', profileId)
        .maybeSingle();

    return response != null;
  }

  /// Получить аватары участников события (первые N).
  Future<List<String>> getParticipantAvatars({
    required String eventId,
    int limit = 5,
  }) async {
    final response = await _client
        .from('event_participants')
        .select('profiles(avatar_url)')
        .eq('event_id', eventId)
        .limit(limit);

    return (response as List)
        .map((e) {
          final profile = e['profiles'] as Map<String, dynamic>?;
          return profile?['avatar_url'] as String? ?? '';
        })
        .where((url) => url.isNotEmpty)
        .toList();
  }

  /// Получить события, в которых участвует пользователь.
  Future<List<Event>> getParticipatingEvents(String profileId) async {
    final response = await _client
        .from('event_participants')
        .select('events(*, event_tags(tags(name)))')
        .eq('profile_id', profileId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      final eventJson = json['events'] as Map<String, dynamic>;
      return _mapEventWithTags(eventJson);
    }).toList();
  }

  /// Маппинг события с вложенными тегами из Supabase join.
  Event _mapEventWithTags(Map<String, dynamic> json) {
    final eventTags = json['event_tags'] as List<dynamic>? ?? [];
    final tags = eventTags
        .map((et) {
          final tag = et['tags'] as Map<String, dynamic>?;
          return tag?['name'] as String? ?? '';
        })
        .where((name) => name.isNotEmpty)
        .toList();

    return Event.fromJson({...json, 'tags': tags});
  }
}
