import 'package:global_diaspora_events/features/notifications/domain/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();
  Stream<List<NotificationModel>> getNotificationsStream();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
  Future<int> getUnreadCount();
}
