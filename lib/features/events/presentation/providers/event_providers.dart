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
