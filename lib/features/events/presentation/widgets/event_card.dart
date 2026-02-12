import 'package:flutter/material.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/event.dart';
import '../../../../app/theme.dart';
import '../../../../core/widgets/glass_container.dart';

/// Карточка события с social proof.
class EventCard extends StatelessWidget {
  final Event event;
  final bool isParticipating;
  final VoidCallback? onTap;
  final VoidCallback? onToggleParticipation;

  const EventCard({
    super.key,
    required this.event,
    this.isParticipating = false,
    this.onTap,
    this.onToggleParticipation,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM, HH:mm');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.adaptiveCard(context),
          borderRadius: BorderRadius.circular(16),
          border: event.isPromoted
              ? Border.all(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  width: 1.5,
                )
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение + Countdown (Hero for smooth transition)
            Stack(
              children: [
                Hero(tag: 'event-image-${event.id}', child: _buildImage()),
                _buildCountdown(context),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promoted badge
                  if (event.isPromoted)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accent, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.promoted,
                        style: TextStyle(
                          fontSize: 11,
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
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Дата и место
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateFormat.format(event.dateStart),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.venueName,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Теги
                  if (event.tags.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: event.tags.take(3).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 12),

                  // Social proof + действия
                  Row(
                    children: [
                      // Participants count
                      _buildSocialProof(context),
                      const Spacer(),

                      // I'm going button
                      _buildGoingButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (event.imageUrl == null || event.imageUrl!.isEmpty) {
      return Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.3),
              AppColors.secondary.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.event_rounded,
            size: 48,
            color: AppColors.textMuted,
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: event.imageUrl!,
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 160,
        color: AppColors.surfaceDark,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        height: 160,
        color: AppColors.surfaceDark,
        child: const Center(
          child: Icon(Icons.broken_image_rounded, color: AppColors.textMuted),
        ),
      ),
    );
  }

  Widget _buildSocialProof(BuildContext context) {
    if (event.participantsCount == 0) {
      return Text(
        AppLocalizations.of(context)!.beFirstToJoin,
        style: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Row(
      children: [
        SizedBox(
          height: 24,
          width:
              24.0 +
              (event.participantsCount > 1 ? 12.0 : 0) +
              (event.participantsCount > 2 ? 12.0 : 0),
          child: Stack(
            children: [
              if (event.participantsCount > 0)
                const Positioned(
                  left: 0,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 14, color: Colors.white),
                  ),
                ),
              if (event.participantsCount > 1)
                Positioned(
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardDark, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 11, // 12 - border
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.person, size: 12, color: Colors.white),
                    ),
                  ),
                ),
              if (event.participantsCount > 2)
                Positioned(
                  left: 32,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardDark, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: AppColors.surfaceDark,
                      child: Text(
                        '+${event.participantsCount - 2}',
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          AppLocalizations.of(context)!.going,
          style: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.8),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGoingButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleParticipation,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isParticipating
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(
                alpha: isParticipating ? 1.0 : 0.4,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isParticipating
                    ? Icons.check_circle_rounded
                    : Icons.add_circle_outline_rounded,
                size: 16,
                color: isParticipating ? Colors.white : AppColors.primaryLight,
              ),
              const SizedBox(width: 6),
              Text(
                isParticipating
                    ? AppLocalizations.of(context)!.imGoingExcited
                    : AppLocalizations.of(context)!.imGoing,
                style: TextStyle(
                  color: isParticipating
                      ? Colors.white
                      : AppColors.primaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountdown(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final diff = event.dateStart.difference(now);

    // Determine label and color
    String label;
    Color badgeColor;

    if (event.dateEnd != null && now.isAfter(event.dateEnd!)) {
      // Event ended
      label = l10n.eventEnded;
      badgeColor = Colors.black54;
    } else if (diff.isNegative) {
      // Happening now
      label = l10n.happeningNow;
      badgeColor = AppColors.success.withValues(alpha: 0.85);
    } else if (diff.inDays > 0) {
      label = l10n.startsIn(l10n.daysShort(diff.inDays));
      badgeColor = Colors.black.withValues(alpha: 0.5);
    } else if (diff.inHours > 0) {
      label = l10n.startsIn(l10n.hoursShort(diff.inHours));
      badgeColor = AppColors.primary.withValues(alpha: 0.8);
    } else {
      label = l10n.startsIn(l10n.minutesShort(diff.inMinutes.clamp(1, 59)));
      badgeColor = AppColors.secondary.withValues(alpha: 0.85);
    }

    return Positioned(
      top: 12,
      right: 12,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: badgeColor,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
