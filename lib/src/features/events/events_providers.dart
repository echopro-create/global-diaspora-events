import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/src/features/events/events_repository.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';
import 'package:global_diaspora_events/src/shared/models/category.dart';
import 'package:global_diaspora_events/src/shared/models/tag.dart';

part 'events_providers.g.dart';

@riverpod
Future<List<Event>> promotedEvents(Ref ref) async {
  return ref.watch(eventsRepositoryProvider).getPromotedEvents();
}

@riverpod
Future<List<Event>> nearbyEvents(Ref ref) async {
  // В реальном приложении здесь бы брались координаты пользователя из Geofence или LocationProvider
  return ref.watch(eventsRepositoryProvider).getEvents();
}

@riverpod
Future<List<Event>> personalizedEvents(Ref ref) async {
  // TODO: Интеграция с интересами пользователя (favorite_artists/tags)
  return ref.watch(eventsRepositoryProvider).getEvents();
}

@riverpod
Future<List<Category>> categories(Ref ref) async {
  return ref.watch(eventsRepositoryProvider).getCategories();
}

@riverpod
Future<List<Tag>> tags(Ref ref) async {
  return ref.watch(eventsRepositoryProvider).getTags();
}
