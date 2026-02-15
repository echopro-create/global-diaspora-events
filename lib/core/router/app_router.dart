import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/events_feed_screen.dart';
import 'package:global_diaspora_events/features/auth/presentation/screens/login_screen.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/event_details_screen.dart';
import 'package:global_diaspora_events/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:global_diaspora_events/features/profile/presentation/screens/profile_screen.dart';
import 'package:global_diaspora_events/features/settings/presentation/screens/settings_screen.dart';
import 'package:global_diaspora_events/features/map/presentation/screens/map_screen.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/create_event_screen.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/my_events_screen.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';
import 'package:global_diaspora_events/features/home/presentation/widgets/scaffold_with_navbar.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(currentUserProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final isLoggingIn = state.uri.path == '/login';
      final isPublicRoute =
          state.uri.path == '/' || state.uri.path.startsWith('/events/');

      if (!isLoggedIn && !isLoggingIn && !isPublicRoute) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const EventsFeedScreen(),
                routes: [
                  GoRoute(
                    path: 'events/:id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final event = state.extra as Event;
                      return EventDetailsScreen(event: event);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-events',
                builder: (context, state) => const MyEventsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // Independent routes (if any, like full-screen modals)
      GoRoute(
        path: '/profile',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/create-event',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final event = state.extra as Event?;
          return CreateEventScreen(eventToEdit: event);
        },
      ),
    ],
  );
}
