import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/events_remote_datasource.dart';
import '../../data/repositories/events_repository_impl.dart';
import '../../domain/entities/event.dart';

/// Provider для EventsRemoteDataSource.
final eventsRemoteDataSourceProvider = Provider<EventsRemoteDataSource>((ref) {
  return EventsRemoteDataSource(ref.watch(supabaseClientProvider));
});

/// Provider для EventsRepository.
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.watch(eventsRemoteDataSourceProvider));
});

/// Provider для списка событий (фильтр по категории — nullable).
final eventsProvider = FutureProvider.family<List<Event>, String?>((
  ref,
  categoryId,
) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getEvents(categoryId: categoryId);
});

/// Provider для геопоиска.
final nearbyEventsProvider =
    FutureProvider.family<
      List<Event>,
      ({double lat, double lng, double radius})
    >((ref, params) async {
      final repo = ref.watch(eventsRepositoryProvider);
      return repo.getNearbyEvents(
        latitude: params.lat,
        longitude: params.lng,
        radiusKm: params.radius,
      );
    });

/// Provider для детальной информации о событии.
final eventDetailProvider = FutureProvider.family<Event, String>((
  ref,
  eventId,
) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getEventById(eventId);
});

/// Provider для переключения участия.
final toggleParticipationProvider =
    FutureProvider.family<bool, ({String eventId, String profileId})>((
      ref,
      params,
    ) async {
      final repo = ref.watch(eventsRepositoryProvider);
      return repo.toggleParticipation(
        eventId: params.eventId,
        profileId: params.profileId,
      );
    });
