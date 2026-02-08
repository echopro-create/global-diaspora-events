import 'package:flutter/material.dart';
import 'package:global_diaspora_events/src/features/events/events_feed_screen.dart';
import 'package:global_diaspora_events/src/features/auth/current_city_screen.dart';
import 'package:global_diaspora_events/src/features/auth/origin_country_screen.dart';
import 'package:global_diaspora_events/src/features/auth/spotify_sync_screen.dart';
import 'package:global_diaspora_events/src/shared/widgets/main_shell.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/onboarding/origin',
    routes: [
      GoRoute(
        path: '/onboarding/origin',
        builder: (context, state) => const OriginCountryScreen(),
      ),
      GoRoute(
        path: '/onboarding/city',
        builder: (context, state) => const CurrentCityScreen(),
      ),
      GoRoute(
        path: '/onboarding/spotify',
        builder: (context, state) => const SpotifySyncScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/feed',
            builder: (context, state) => const EventsFeedScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Search Screen'))),
          ),
          GoRoute(
            path: '/tickets',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Tickets Screen'))),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Profile Screen'))),
          ),
        ],
      ),
    ],
  );
}
