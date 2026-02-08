import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';

part 'events_repository.g.dart';

class EventsRepository {
  final SupabaseClient _supabase;

  EventsRepository(this._supabase);

  Future<List<Event>> getEvents({
    String? categoryId,
    double? radiusInKm,
    double? lat,
    double? lon,
  }) async {
    var query = _supabase.from('events').select();

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    // Geo filtering using PostGIS (simplified approach for now)
    // Real implementation would use an RPC call or complex select with filters
    final response = await query.order('start_time');

    return (response as List).map((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event>> getPromotedEvents() async {
    final response = await _supabase
        .from('events')
        .select()
        .eq('is_promoted', true)
        .limit(5);
    return (response as List).map((e) => Event.fromJson(e)).toList();
  }
}

@riverpod
EventsRepository eventsRepository(EventsRepositoryRef ref) {
  return EventsRepository(Supabase.instance.client);
}
