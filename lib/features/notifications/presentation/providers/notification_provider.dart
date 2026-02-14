import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:global_diaspora_events/features/notifications/data/notification_service.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';

part 'notification_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return NotificationService(supabase);
}
