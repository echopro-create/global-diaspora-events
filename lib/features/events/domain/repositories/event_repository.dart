import 'package:global_diaspora_events/features/events/domain/models/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents({int limit = 20, int offset = 0});
  Future<List<Event>> getEventsNearby({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
  });
  Future<List<Event>> getRecommendedEvents();
  Future<Event> getEventById(String id);
  Future<void> toggleAttendance(String eventId);
}
