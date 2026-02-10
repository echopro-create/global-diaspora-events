import '../../domain/entities/event.dart';
import '../datasources/events_remote_datasource.dart';

/// Репозиторий событий.
class EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;

  EventsRepository(this._remoteDataSource);

  Future<List<Event>> getEvents({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  }) {
    return _remoteDataSource.getEvents(
      categoryId: categoryId,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Event>> getNearbyEvents({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
    int limit = 20,
  }) {
    return _remoteDataSource.getNearbyEvents(
      latitude: latitude,
      longitude: longitude,
      radiusKm: radiusKm,
      limit: limit,
    );
  }

  Future<Event> getEventById(String id) {
    return _remoteDataSource.getEventById(id);
  }

  Future<bool> toggleParticipation({
    required String eventId,
    required String profileId,
  }) {
    return _remoteDataSource.toggleParticipation(
      eventId: eventId,
      profileId: profileId,
    );
  }

  Future<bool> isParticipating({
    required String eventId,
    required String profileId,
  }) {
    return _remoteDataSource.isParticipating(
      eventId: eventId,
      profileId: profileId,
    );
  }

  Future<List<String>> getParticipantAvatars({
    required String eventId,
    int limit = 5,
  }) {
    return _remoteDataSource.getParticipantAvatars(
      eventId: eventId,
      limit: limit,
    );
  }
}
