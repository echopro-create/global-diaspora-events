import 'package:go_router/go_router.dart';

import '../features/events/presentation/screens/event_detail_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';

/// Маршрутизация приложения.
abstract final class AppRouter {
  /// Названия маршрутов.
  static const home = '/';
  static const eventDetail = '/event/:id';
  static const onboarding = '/onboarding';
  static const profile = '/profile';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const EventsScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: eventDetail,
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailScreen(eventId: eventId);
        },
      ),
    ],
  );
}
