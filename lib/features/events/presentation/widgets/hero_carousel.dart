import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../domain/entities/event.dart';

/// Hero Carousel — большие карточки promoted/featured событий.
class HeroCarousel extends StatefulWidget {
  final List<Event> events;
  final void Function(Event event) onTap;

  const HeroCarousel({super.key, required this.events, required this.onTap});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.92);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || widget.events.isEmpty) return;
      final nextPage = (_currentPage + 1) % widget.events.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              final event = widget.events[index];
              return _HeroCard(event: event, onTap: () => widget.onTap(event));
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.events.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: _currentPage == index ? 24 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : AppColors.textMuted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const _HeroCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, d MMM · HH:mm');
    final now = DateTime.now();
    final diff = event.dateStart.difference(now);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Фоновое изображение
            if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: event.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.cardDark),
                errorWidget: (_, _, _) => Container(color: AppColors.cardDark),
              )
            else
              Container(
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
              ),

            // Gradient overlay для читаемости
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.2, 0.5, 1.0],
                ),
              ),
            ),

            // Countdown badge
            if (diff.isNegative == false)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    _formatCountdown(diff),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // Контент внизу
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Дата
                  Text(
                    dateFormat.format(event.dateStart),
                    style: TextStyle(
                      color: AppColors.accent.withValues(alpha: 0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Название
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Место + участники
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.venueName,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (event.participantsCount > 0) ...[
                        const SizedBox(width: 12),
                        Icon(
                          Icons.people_rounded,
                          size: 14,
                          color: AppColors.primary.withValues(alpha: 0.9),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${event.participantsCount}',
                          style: TextStyle(
                            color: AppColors.primary.withValues(alpha: 0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  String _formatCountdown(Duration diff) {
    if (diff.inDays > 0) {
      return 'in ${diff.inDays}d';
    } else if (diff.inHours > 0) {
      return 'in ${diff.inHours}h';
    } else {
      return 'in ${diff.inMinutes}m';
    }
  }
}
