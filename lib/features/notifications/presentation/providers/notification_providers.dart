import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'package:global_diaspora_events/features/notifications/domain/models/notification_model.dart';
import 'package:global_diaspora_events/features/notifications/domain/repositories/notification_repository.dart';
import 'package:global_diaspora_events/features/notifications/data/repositories/notification_repository_impl.dart';

part 'notification_providers.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return NotificationRepositoryImpl(client);
}

@riverpod
Stream<List<NotificationModel>> notificationsStream(Ref ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getNotificationsStream();
}

@riverpod
Future<int> unreadNotificationsCount(Ref ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getUnreadCount();
}
