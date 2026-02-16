import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/application/auth_state_provider.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/country_selection_screen.dart';
import '../../features/onboarding/presentation/screens/city_selection_screen.dart';

part 'app_router.g.dart';

/// GoRouter configuration provider.
@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.asData?.value != null;
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register');

      // Redirect to events if authenticated and trying to access auth pages
      if (isAuthenticated && isAuthRoute) {
        return '/events';
      }

      // Redirect to login if not authenticated and trying to access protected pages
      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }

      return null; // No redirect
    },
    routes: [
      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Placeholder for events (Week 2)
      GoRoute(
        path: '/events',
        name: 'events',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Events Screen - Coming in Week 2'),
          ),
        ),
      ),

      // Onboarding routes
      GoRoute(
        path: '/onboarding/welcome',
        name: 'onboarding_welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/country',
        name: 'onboarding_country',
        builder: (context, state) => const CountrySelectionScreen(),
      ),
      GoRoute(
        path: '/onboarding/city',
        name: 'onboarding_city',
        builder: (context, state) => const CitySelectionScreen(),
      ),
    ],
  );
}
