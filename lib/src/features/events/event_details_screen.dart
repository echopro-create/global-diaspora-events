import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/auth/auth_service.dart';
import 'package:global_diaspora_events/src/features/events/events_providers.dart';
import 'package:global_diaspora_events/src/features/events/events_repository.dart';
import 'package:global_diaspora_events/src/features/events/widgets/event_map_view.dart';
import 'package:global_diaspora_events/src/features/events/widgets/event_participation_widget.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventDetailsScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  bool _isJoining = false;

  Future<void> _toggleJoin(Event event) async {
    setState(() => _isJoining = true);
    try {
      if (event.isUserJoined) {
        await ref.read(eventsRepositoryProvider).leaveEvent(widget.eventId);
      } else {
        await ref.read(eventsRepositoryProvider).joinEvent(widget.eventId);
      }
      // Перезагружаем данные события
      ref.invalidate(eventDetailsProvider(widget.eventId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) setState(() => _isJoining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventDetailsProvider(widget.eventId));
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      body: eventAsync.when(
        data: (event) => _buildContent(context, event, profileAsync),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Event event,
    AsyncValue<Map<String, dynamic>> profileAsync,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: event.imageUrl != null
                ? Image.network(event.imageUrl!, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.event, size: 100),
                  ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event.category?.name ?? 'Без категории',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              profileAsync.maybeWhen(
                data: (profile) => EventParticipationWidget(
                  participantsCount: event.participantsCount,
                  originCountry: profile['origin_country'] ?? 'Ваша страна',
                ),
                orElse: () => _buildInfoRow(
                  Icons.people,
                  '${event.participantsCount} участников',
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoRow(Icons.calendar_today, event.startTime.toString()),
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.location_on,
                event.address ?? 'Адрес не указан',
              ),
              const SizedBox(height: 32),
              const Text(
                'Описание',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                event.description ?? 'Описание отсутствует',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              EventMapView(
                lat: event.location?.latitude,
                lon: event.location?.longitude,
                address: event.address,
              ),
              const SizedBox(height: 48),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isJoining ? null : () => _toggleJoin(event),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: event.isUserJoined
                            ? Colors.white10
                            : Theme.of(context).primaryColor,
                      ),
                      child: _isJoining
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              event.isUserJoined
                                  ? 'Вы идете'
                                  : 'Присоединиться',
                            ),
                    ),
                  ),
                  if (event.buyLink != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          final url = Uri.parse(event.buyLink!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text('Купить билеты'),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white54),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
