import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/mock_events.dart';
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
/// Fallback: Supabase недоступен → мок-данные.
final eventsProvider = FutureProvider.family<List<Event>, String?>((
  ref,
  categoryId,
) async {
  try {
    final repo = ref.watch(eventsRepositoryProvider);
    return await repo.getEvents(categoryId: categoryId);
  } catch (_) {
    // Supabase недоступен → fallback на мок-данные
    if (categoryId != null) return MockEvents.byCategory(categoryId);
    return MockEvents.all;
  }
});

/// Provider для геопоиска.
/// Fallback: мок-данные с простым haversine-фильтром.
final nearbyEventsProvider =
    FutureProvider.family<
      List<Event>,
      ({double lat, double lng, double radius})
    >((ref, params) async {
      try {
        final repo = ref.watch(eventsRepositoryProvider);
        return await repo.getNearbyEvents(
          latitude: params.lat,
          longitude: params.lng,
          radiusKm: params.radius,
        );
      } catch (_) {
        return MockEvents.nearby(
          lat: params.lat,
          lng: params.lng,
          radiusKm: params.radius,
        );
      }
    });

/// Provider для детальной информации о событии.
/// Fallback: мок-событие по ID.
final eventDetailProvider = FutureProvider.family<Event, String>((
  ref,
  eventId,
) async {
  try {
    final repo = ref.watch(eventsRepositoryProvider);
    return await repo.getEventById(eventId);
  } catch (_) {
    final mock = MockEvents.byId(eventId);
    if (mock != null) return mock;
    rethrow;
  }
});

/// Provider для переключения участия (toggle + invalidate).
final toggleParticipationProvider =
    FutureProvider.family<bool, ({String eventId, String profileId})>((
      ref,
      params,
    ) async {
      final repo = ref.watch(eventsRepositoryProvider);
      final result = await repo.toggleParticipation(
        eventId: params.eventId,
        profileId: params.profileId,
      );
      // Invalidate cached participation status
      ref.invalidate(
        isParticipatingProvider((
          eventId: params.eventId,
          profileId: params.profileId,
        )),
      );
      // Refresh event detail to update participant count
      ref.invalidate(eventDetailProvider(params.eventId));
      return result;
    });

/// Provider для проверки участия текущего пользователя в событии.
/// Fallback: false если Supabase недоступен.
final isParticipatingProvider =
    FutureProvider.family<bool, ({String eventId, String profileId})>((
      ref,
      params,
    ) async {
      try {
        final repo = ref.watch(eventsRepositoryProvider);
        return await repo.isParticipating(
          eventId: params.eventId,
          profileId: params.profileId,
        );
      } catch (_) {
        return false;
      }
    });

/// Перечисление вариантов фильтрации по дате.
enum DateFilter { all, thisWeek, thisMonth }

/// StateProvider для текущего фильтра по дате.
final dateFilterProvider = StateProvider<DateFilter>((_) => DateFilter.all);

/// Provider для списка «Мои события» (события, где пользователь записан).
final myEventsProvider = FutureProvider<List<Event>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  try {
    final repo = ref.watch(eventsRepositoryProvider);
    return await repo.getParticipatingEvents(user.id);
  } catch (_) {
    // Fallback: пустой список или мок-данные при ошибке
    return [];
  }
});

/// Provider для отфильтрованных по дате событий.
final filteredEventsProvider = FutureProvider.family<List<Event>, String?>((
  ref,
  categoryId,
) async {
  final events = await ref.watch(eventsProvider(categoryId).future);
  final filter = ref.watch(dateFilterProvider);

  if (filter == DateFilter.all) return events;

  final now = DateTime.now();
  return events.where((e) {
    switch (filter) {
      case DateFilter.thisWeek:
        final diff = e.dateStart.difference(now).inDays;
        return diff >= 0 && diff <= 7;
      case DateFilter.thisMonth:
        return e.dateStart.year == now.year && e.dateStart.month == now.month;
      case DateFilter.all:
        return true;
    }
  }).toList();
});
