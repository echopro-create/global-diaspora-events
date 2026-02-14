import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/features/events/domain/repositories/event_repository.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/data/repositories/event_repository_impl.dart';

part 'event_providers.g.dart';

@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

@riverpod
EventRepository eventRepository(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return EventRepositoryImpl(client);
}

@riverpod
Future<List<Event>> events(Ref ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getEvents();
}

@riverpod
Future<List<Event>> nearbyEvents(Ref ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  // Defaulting to San Francisco for demo purposes if location service isn't implemented
  return repository.getEventsNearby(latitude: 37.7749, longitude: -122.4194);
}

@riverpod
Future<List<Event>> recommendedEvents(Ref ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getRecommendedEvents();
}
