import 'package:flutter/material.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme.dart';
import '../../../../core/providers/core_providers.dart';
import '../../domain/entities/event.dart';
import '../providers/events_providers.dart';

/// Экран детальной информации о событии.
class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.failedToLoadEvent,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(eventDetailProvider(eventId)),
                child: Text(AppLocalizations.of(context)!.tryAgain),
              ),
            ],
          ),
        ),
        data: (event) {
          final dateFormat = DateFormat('EEEE, d MMMM yyyy • HH:mm');

          return CustomScrollView(
            slivers: [
              // Hero image
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.isDark(context)
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onPressed: () => _shareEvent(context, event),
                  ),
                  const SizedBox(width: 4),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'event-image-${event.id}',
                    child: event.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: event.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(color: AppColors.surfaceDark),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.4),
                                  AppColors.secondary.withValues(alpha: 0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.event_rounded,
                                size: 64,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promoted badge
                      if (event.isPromoted)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.accent, AppColors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.promotedEvent,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                      // Название
                      Text(
                        event.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Info tiles
                      _buildInfoTile(
                        Icons.calendar_today_rounded,
                        AppColors.primary,
                        dateFormat.format(event.dateStart),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoTile(
                        Icons.location_on_rounded,
                        AppColors.secondary,
                        '${event.venueName}${event.venueAddress != null ? '\n${event.venueAddress}' : ''}',
                      ),
                      const SizedBox(height: 10),
                      _buildInfoTile(
                        Icons.people_rounded,
                        AppColors.primaryLight,
                        AppLocalizations.of(
                          context,
                        )!.peopleGoing(event.participantsCount),
                      ),

                      const SizedBox(height: 24),

                      // Tags
                      if (event.tags.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.tags.map((tag) {
                            return Chip(
                              label: Text(
                                '#$tag',
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 13,
                                ),
                              ),
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.15,
                              ),
                              side: BorderSide.none,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Description
                      Text(
                        AppLocalizations.of(context)!.about,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Action buttons
                      _buildActionButtons(context, ref, event),

                      const SizedBox(height: 12),

                      // Add to Calendar
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _addToCalendar(context, event),
                          icon: const Icon(Icons.calendar_month_rounded),
                          label: Text(
                            AppLocalizations.of(context)!.addToCalendar,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Action buttons: I'm Going (toggle) + Buy Ticket.
  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Event event) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);
    final profileId = user?.id;

    // Watch participation status (only if logged in)
    final isGoingAsync = profileId != null
        ? ref.watch(
            isParticipatingProvider((eventId: event.id, profileId: profileId)),
          )
        : const AsyncValue<bool>.data(false);

    final isGoing = isGoingAsync.valueOrNull ?? false;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (profileId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.loginToParticipate)),
                );
                return;
              }
              ref.read(
                toggleParticipationProvider((
                  eventId: event.id,
                  profileId: profileId,
                )),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isGoing
                  ? AppColors.success
                  : Theme.of(context).colorScheme.primary,
            ),
            icon: Icon(
              isGoing ? Icons.check_circle : Icons.check_circle_outline,
            ),
            label: Text(isGoing ? l10n.going : l10n.imGoing),
          ),
        ),
        const SizedBox(width: 12),
        if (event.buyLink != null)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(event.buyLink!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.confirmation_number_rounded),
              label: Text(l10n.buyTicket),
            ),
          ),
      ],
    );
  }

  /// Share event via system share dialog.
  void _shareEvent(BuildContext context, Event event) {
    final dateFormat = DateFormat('d MMM yyyy, HH:mm');
    final deepLink = 'https://gde.app/event/${event.id}';
    final text =
        '${event.title}\n'
        '${dateFormat.format(event.dateStart)}\n'
        '${event.venueName}\n\n'
        '$deepLink';
    SharePlus.instance.share(ShareParams(text: text, uri: Uri.parse(deepLink)));
  }

  /// Open calendar intent.
  Future<void> _addToCalendar(BuildContext context, Event event) async {
    final start = event.dateStart;
    final end = event.dateEnd ?? start.add(const Duration(hours: 2));
    // Google Calendar URL scheme
    final uri = Uri.parse(
      'https://calendar.google.com/calendar/render'
      '?action=TEMPLATE'
      '&text=${Uri.encodeComponent(event.title)}'
      '&dates=${_calendarDate(start)}/${_calendarDate(end)}'
      '&location=${Uri.encodeComponent(event.venueName)}'
      '&details=${Uri.encodeComponent(event.description.length > 200 ? event.description.substring(0, 200) : event.description)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _calendarDate(DateTime dt) {
    return '${dt.year}${_pad(dt.month)}${_pad(dt.day)}'
        'T${_pad(dt.hour)}${_pad(dt.minute)}00';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  Widget _buildInfoTile(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
