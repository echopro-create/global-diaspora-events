import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/domain/models/event_filter.dart';
import 'dart:io';

abstract class EventRepository {
  Future<List<Event>> getEvents({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    EventFilter? filter,
  });
  Future<List<Event>> getEventsNearby({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
  });
  Future<List<Event>> getRecommendedEvents();
  Future<Event> getEventById(String id);
  Future<void> toggleAttendance(String eventId);
  Future<void> toggleFavorite(String eventId);
  Future<void> createEvent(Event event, File? imageFile);
  Future<void> updateEvent(Event event, File? imageFile);
  Future<void> deleteEvent(String eventId);
  Future<List<Event>> getMyEvents();
}
