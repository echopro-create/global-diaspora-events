import 'package:flutter_test/flutter_test.dart';
import 'package:gde/features/events/domain/entities/event.dart';

/// Countdown logic as used in EventCard._buildCountdown
/// Extracted for unit-testability.
String computeCountdownText(Event event, DateTime now) {
  final diff = event.dateStart.difference(now);

  // Event ended
  final end = event.dateEnd ?? event.dateStart.add(const Duration(hours: 2));
  if (now.isAfter(end)) {
    return 'Event ended';
  }

  // Happening now
  if (now.isAfter(event.dateStart) && now.isBefore(end)) {
    return 'Happening now';
  }

  // Future
  if (diff.inDays > 0) {
    return '${diff.inDays}d';
  }
  if (diff.inHours > 0) {
    return '${diff.inHours}h';
  }
  return '${diff.inMinutes}m';
}

void main() {
  group('Countdown Logic', () {
    late Event event;

    setUp(() {
      event = Event(
        id: 'cd-1',
        title: 'Countdown Test',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 6, 15, 18, 0),
        dateEnd: DateTime(2026, 6, 15, 22, 0),
        createdAt: DateTime(2026, 1, 1),
      );
    });

    test('shows days when event is days away', () {
      final now = DateTime(2026, 6, 10, 18, 0); // 5 days before
      expect(computeCountdownText(event, now), '5d');
    });

    test('shows hours when event is hours away', () {
      final now = DateTime(2026, 6, 15, 14, 0); // 4 hours before
      expect(computeCountdownText(event, now), '4h');
    });

    test('shows minutes when event is less than 1 hour away', () {
      final now = DateTime(2026, 6, 15, 17, 30); // 30 min before
      expect(computeCountdownText(event, now), '30m');
    });

    test('shows "Happening now" during event', () {
      final now = DateTime(2026, 6, 15, 20, 0); // middle of event
      expect(computeCountdownText(event, now), 'Happening now');
    });

    test('shows "Event ended" after event ends', () {
      final now = DateTime(2026, 6, 16, 0, 0); // after event ended
      expect(computeCountdownText(event, now), 'Event ended');
    });

    test('handles event without dateEnd (defaults to +2h)', () {
      final noEndEvent = Event(
        id: 'cd-2',
        title: 'No End',
        categoryId: 'cat-1',
        dateStart: DateTime(2026, 6, 15, 18, 0),
        createdAt: DateTime(2026, 1, 1),
      );

      // During default window (18:00 - 20:00)
      final during = DateTime(2026, 6, 15, 19, 0);
      expect(computeCountdownText(noEndEvent, during), 'Happening now');

      // After default window
      final after = DateTime(2026, 6, 15, 21, 0);
      expect(computeCountdownText(noEndEvent, after), 'Event ended');
    });

    test('shows "1d" for exactly 24h diff', () {
      final now = DateTime(2026, 6, 14, 18, 0); // exactly 1 day before
      expect(computeCountdownText(event, now), '1d');
    });

    test('shows "1h" for exactly 1 hour diff', () {
      final now = DateTime(2026, 6, 15, 17, 0); // exactly 1h before
      expect(computeCountdownText(event, now), '1h');
    });
  });
}
