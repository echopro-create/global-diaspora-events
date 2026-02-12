import 'package:flutter_test/flutter_test.dart';
import 'package:gde/features/events/domain/entities/event.dart';

void main() {
  group('Event Entity', () {
    test('creates Event with required fields', () {
      final event = Event(
        id: 'test-1',
        title: 'Test Event',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 3, 15, 18, 0),
        createdAt: DateTime.now(),
      );

      expect(event.id, 'test-1');
      expect(event.title, 'Test Event');
      expect(event.categoryId, 'cat-1');
      expect(event.description, '');
      expect(event.isPromoted, false);
      expect(event.participantsCount, 0);
      expect(event.tags, isEmpty);
    });

    test('creates Event with all optional fields', () {
      final event = Event(
        id: 'test-2',
        title: 'Full Event',
        description: 'A full description',
        categoryId: 'cat-2',
        dateStart: DateTime(2026, 3, 15, 18, 0),
        dateEnd: DateTime(2026, 3, 15, 22, 0),
        venueName: 'Test Venue',
        venueAddress: '123 Street',
        latitude: 52.52,
        longitude: 13.405,
        imageUrl: 'https://example.com/img.jpg',
        buyLink: 'https://tickets.com',
        isPromoted: true,
        participantsCount: 42,
        tags: ['music', 'live'],
        createdAt: DateTime.now(),
      );

      expect(event.description, 'A full description');
      expect(event.latitude, 52.52);
      expect(event.longitude, 13.405);
      expect(event.isPromoted, true);
      expect(event.participantsCount, 42);
      expect(event.tags, ['music', 'live']);
      expect(event.dateEnd, isNotNull);
      expect(event.buyLink, 'https://tickets.com');
    });

    test('JSON serialization/deserialization round-trip', () {
      final original = Event(
        id: 'json-test',
        title: 'JSON Event',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 6, 1, 10, 0),
        createdAt: DateTime(2026, 1, 1),
        latitude: 48.8566,
        longitude: 2.3522,
        tags: ['paris', 'culture'],
        participantsCount: 15,
      );

      final json = original.toJson();
      final restored = Event.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.latitude, original.latitude);
      expect(restored.longitude, original.longitude);
      expect(restored.tags, original.tags);
      expect(restored.participantsCount, original.participantsCount);
    });

    test('copyWith works correctly', () {
      final event = Event(
        id: 'copy-test',
        title: 'Original',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 3, 15),
        createdAt: DateTime.now(),
      );

      final modified = event.copyWith(title: 'Modified', isPromoted: true);

      expect(modified.title, 'Modified');
      expect(modified.isPromoted, true);
      expect(modified.id, event.id);
      expect(modified.categoryId, event.categoryId);
    });

    test('equality works correctly', () {
      final now = DateTime(2026, 1, 1);
      final a = Event(
        id: 'eq-1',
        title: 'Same',
        categoryId: 'cat-1',
        dateStart: now,
        createdAt: now,
      );
      final b = Event(
        id: 'eq-1',
        title: 'Same',
        categoryId: 'cat-1',
        dateStart: now,
        createdAt: now,
      );
      final c = Event(
        id: 'eq-2',
        title: 'Different',
        categoryId: 'cat-1',
        dateStart: now,
        createdAt: now,
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, b.hashCode);
    });
  });

  group('Event geo helpers', () {
    test('event with coordinates is geo-mappable', () {
      final event = Event(
        id: 'geo-1',
        title: 'Located Event',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 3, 15),
        createdAt: DateTime.now(),
        latitude: 52.52,
        longitude: 13.405,
      );

      expect(event.latitude, isNotNull);
      expect(event.longitude, isNotNull);
    });

    test('event without coordinates is not geo-mappable', () {
      final event = Event(
        id: 'geo-2',
        title: 'No Location',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 3, 15),
        createdAt: DateTime.now(),
      );

      expect(event.latitude, isNull);
      expect(event.longitude, isNull);
    });
  });
}
