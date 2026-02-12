import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/events/presentation/screens/event_detail_screen.dart';
import '../features/events/presentation/screens/events_map_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/events/presentation/screens/search_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import 'widgets/main_shell.dart';

/// Маршрутизация приложения.
abstract final class AppRouter {
  /// Ключи навигации для каждой ветки.
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _discoverKey = GlobalKey<NavigatorState>(debugLabel: 'discover');
  static final _searchKey = GlobalKey<NavigatorState>(debugLabel: 'search');
  static final _profileKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  /// Именованные маршруты.
  static const splash = '/splash';
  static const home = '/';
  static const eventDetail = '/event/:id';
  static const map = '/map';
  static const onboarding = '/onboarding';
  static const profile = '/profile';

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      // Онбординг — без BottomNavigationBar
      GoRoute(
        path: onboarding,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Event Detail — без BottomNavigationBar (full-screen)
      GoRoute(
        path: eventDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailScreen(eventId: eventId);
        },
      ),

      // Map View — full-screen
      GoRoute(
        path: map,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const EventsMapScreen(),
      ),

      // Основная навигация с BottomNavigationBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Discover branch
          StatefulShellBranch(
            navigatorKey: _discoverKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const EventsScreen(),
              ),
            ],
          ),

          // Search branch
          StatefulShellBranch(
            navigatorKey: _searchKey,
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),

          // Profile branch
          StatefulShellBranch(
            navigatorKey: _profileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
