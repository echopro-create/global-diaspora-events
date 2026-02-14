import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/features/notifications/data/notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notification_provider.g.dart';

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService(Supabase.instance.client);
}
