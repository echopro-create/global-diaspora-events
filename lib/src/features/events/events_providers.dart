import 'package:global_diaspora_events/src/features/auth/auth_service.dart';
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
  final profileAsync = ref.watch(userProfileProvider);
  return profileAsync.maybeWhen(
    data: (profile) {
      final location = profile['current_location'] as Map?;
      if (location != null) {
        final coords = location['coordinates'] as List;
        return ref
            .watch(eventsRepositoryProvider)
            .getEvents(
              lat: coords[1].toDouble(),
              lon: coords[0].toDouble(),
              radiusInKm: 50, // Радиус по умолчанию
            );
      }
      return ref.watch(eventsRepositoryProvider).getEvents();
    },
    orElse: () => ref.watch(eventsRepositoryProvider).getEvents(),
  );
}

@riverpod
Future<List<Event>> personalizedEvents(Ref ref) async {
  // В V1 возвращаем события, но в будущем здесь будет фильтрация по profile['favorite_artists']
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

@riverpod
Future<Event> eventDetails(Ref ref, String id) async {
  return ref.watch(eventsRepositoryProvider).getEventById(id);
}
