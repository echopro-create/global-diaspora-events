import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/events_feed_screen.dart';
import 'package:global_diaspora_events/features/auth/presentation/screens/login_screen.dart';
import 'package:global_diaspora_events/features/events/presentation/screens/event_details_screen.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const EventsFeedScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/events/:id',
        builder: (context, state) {
          final event = state.extra as Event;
          return EventDetailsScreen(event: event);
        },
      ),
    ],
  );
}
