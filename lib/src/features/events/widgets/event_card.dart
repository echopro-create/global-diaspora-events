import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:global_diaspora_events/src/core/app_colors.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback onJoinTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        event.imageUrl ?? 'https://via.placeholder.com/400x225',
                    fit: BoxFit.cover,
                  ),
                  if (event.isPromoted)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'РЕКОМЕНДОВАНО',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onJoinTap,
                        icon: Icon(
                          event.isUserJoined
                              ? Icons.check_circle
                              : Icons.add_circle_outline,
                          color: event.isUserJoined
                              ? AppColors.success
                              : AppColors.primary,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('d MMMM, HH:mm').format(event.startTime),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildAvatarStack(),
                      const SizedBox(width: 12),
                      Text(
                        '+${event.participantsCount} человека идут',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 60,
      height: 24,
      child: Stack(
        children: List.generate(3, (index) {
          return Positioned(
            left: index * 14.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.surface, width: 2),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/100?u=$index',
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
