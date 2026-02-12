import 'package:flutter_test/flutter_test.dart';
import 'package:gde/core/data/mock_events.dart';

void main() {
  group('MockEvents', () {
    test('all returns non-empty list', () {
      expect(MockEvents.all, isNotEmpty);
      expect(MockEvents.all.length, greaterThanOrEqualTo(5));
    });

    test('all mock events have required fields', () {
      for (final event in MockEvents.all) {
        expect(event.id, isNotEmpty);
        expect(event.title, isNotEmpty);
        expect(event.categoryId, isNotEmpty);
        expect(event.dateStart, isNotNull);
        expect(event.createdAt, isNotNull);
      }
    });

    test('all mock events have coordinates', () {
      for (final event in MockEvents.all) {
        expect(
          event.latitude,
          isNotNull,
          reason: '${event.title} should have latitude',
        );
        expect(
          event.longitude,
          isNotNull,
          reason: '${event.title} should have longitude',
        );
      }
    });

    test('mock events have unique IDs', () {
      final ids = MockEvents.all.map((e) => e.id).toSet();
      expect(ids.length, MockEvents.all.length);
    });

    test('at least one mock event is promoted', () {
      expect(MockEvents.featured, isNotEmpty);
    });

    test('byId returns correct event', () {
      final event = MockEvents.byId('mock-001');
      expect(event, isNotNull);
      expect(event!.title, contains('Georgian'));
    });

    test('byId returns null for unknown ID', () {
      expect(MockEvents.byId('nonexistent'), isNull);
    });

    test('nearby returns events within radius', () {
      // Berlin center
      final nearby = MockEvents.nearby(lat: 52.52, lng: 13.405, radiusKm: 20);
      expect(nearby, isNotEmpty);
      // All returned must have coordinates
      for (final e in nearby) {
        expect(e.latitude, isNotNull);
        expect(e.longitude, isNotNull);
      }
    });

    test('nearby returns empty for remote location', () {
      // Middle of Pacific Ocean
      final nearby = MockEvents.nearby(lat: 0, lng: -150, radiusKm: 10);
      expect(nearby, isEmpty);
    });
  });
}
