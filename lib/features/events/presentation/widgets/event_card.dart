import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'dart:ui';

class EventCard extends ConsumerStatefulWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventCard({super.key, required this.event, this.onTap});

  @override
  ConsumerState<EventCard> createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  bool _isGoing = false;
  bool _isLoading = false;

  void _toggleAttendance() async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      context.push('/login');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(eventRepositoryProvider).toggleAttendance(widget.event.id);
      if (mounted) {
        setState(() {
          _isGoing = !_isGoing;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = widget.event;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: widget.onTap,
          child: Stack(
            children: [
              // Event Image
              AspectRatio(
                aspectRatio: 1.2,
                child: event.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: event.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
              ),

              // Gradient Overlay for readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 0.4, 0.9],
                    ),
                  ),
                ),
              ),

              // Promoted Badge
              if (event.isPromoted)
                Positioned(
                  top: 16,
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PROMOTED',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Content
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          DateFormat(
                            'MMM dd, yyyy • HH:mm',
                          ).format(event.dateStart),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.house, size: 14, color: Colors.white70),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.venueName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildParticipantAvatars(event.participantsCount),
                        const Spacer(),
                        TextButton(
                          onPressed: _isLoading ? null : _toggleAttendance,
                          style: TextButton.styleFrom(
                            backgroundColor: _isGoing
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  )
                                : Colors.white,
                            foregroundColor: _isGoing
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: _isGoing
                                  ? BorderSide(color: theme.colorScheme.primary)
                                  : BorderSide.none,
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(_isGoing ? 'GOING' : 'I\'M GOING'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantAvatars(int count) {
    if (count == 0) return const SizedBox.shrink();
    return Row(
      children: [
        for (var i = 0; i < (count > 3 ? 3 : count); i++)
          Align(
            widthFactor: 0.6,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 12),
            ),
          ),
        if (count > 3)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '+${count - 3} going',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '$count going',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
