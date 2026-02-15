import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/social/presentation/widgets/comments_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late Event _event;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  Future<void> _toggleAttendance() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(eventRepositoryProvider);
      await repository.toggleAttendance(_event.id);
      setState(() {
        _event = _event.copyWith(
          isAttending: !_event.isAttending,
          participantsCount: _event.isAttending
              ? _event.participantsCount - 1
              : _event.participantsCount + 1,
        );
      });

      // Refresh event lists to reflect changes
      ref.invalidate(eventsProvider);
      ref.invalidate(nearbyEventsProvider);
      ref.invalidate(recommendedEventsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _event.isAttending
                  ? 'You are now attending this event!'
                  : 'You are no longer attending this event.',
            ),
            backgroundColor: _event.isAttending ? Colors.green : Colors.grey,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update attendance: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(eventRepositoryProvider);
      await repository.toggleFavorite(_event.id);
      setState(() {
        _event = _event.copyWith(isFavorite: !_event.isFavorite);
      });

      // Refresh event lists
      ref.invalidate(eventsProvider);
      ref.invalidate(nearbyEventsProvider);
      ref.invalidate(recommendedEventsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _event.isFavorite
                  ? 'Event added to favorites!'
                  : 'Event removed from favorites.',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update favorites: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteEvent() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(eventRepositoryProvider).deleteEvent(_event.id);
      ref.invalidate(eventsProvider);
      ref.invalidate(myEventsProvider);
      if (mounted) {
        context.pop(); // Close details
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete event: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _editEvent() async {
    await context.push('/create-event', extra: _event);
    // Refresh event data
    try {
      final updatedEvent = await ref
          .read(eventRepositoryProvider)
          .getEventById(_event.id);
      if (mounted) {
        setState(() {
          _event = updatedEvent;
        });
      }
    } catch (e) {
      // Ignore error if event was deleted or fetch failed, or handle it
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = _event;
    final theme = Theme.of(context);

    // Format date and time
    final date = event.dateStart;
    final time = TimeOfDay.fromDateTime(date);
    // ignore: deprecated_member_use
    final dateString = '${date.day}/${date.month}/${date.year}';
    final timeString = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndHost(theme),
                  const SizedBox(height: 24),
                  _buildDateTimeLocation(theme, dateString, timeString),
                  const SizedBox(height: 24),
                  _buildDescription(theme),
                  const SizedBox(height: 24),
                  _buildAttendees(theme),
                  const SizedBox(height: 24),
                  CommentsSection(eventId: widget.event.id),
                  const SizedBox(height: 100), // Spacing for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildJoinButton(context, theme, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ThemeData theme) {
    final currentUser = ref.watch(currentUserProvider);
    final isOwner = currentUser?.id == _event.organizerId;

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      stretch: true,
      backgroundColor: theme.colorScheme.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(
          // ignore: deprecated_member_use
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, size: 20),
          onPressed: () {
            // ignore: deprecated_member_use
            Share.share(
              'Check out ${_event.title} at ${_event.venueName}! ${_event.buyLink ?? ""}',
              subject: 'Event Invitation: ${_event.title}',
            );
          },
          style: IconButton.styleFrom(
            // ignore: deprecated_member_use
            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            _event.isFavorite
                ? FontAwesomeIcons.solidHeart
                : FontAwesomeIcons.heart,
            size: 20,
            color: _event.isFavorite ? Colors.red : null,
          ),
          onPressed: _isLoading ? null : _toggleFavorite,
          style: IconButton.styleFrom(
            // ignore: deprecated_member_use
            backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
          ),
        ),
        if (isOwner) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: _editEvent,
            style: IconButton.styleFrom(
              // ignore: deprecated_member_use
              backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: _isLoading ? null : _deleteEvent,
            style: IconButton.styleFrom(
              // ignore: deprecated_member_use
              backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
            ),
          ),
        ],
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'event_image_${_event.id}',
          child: _event.imageUrl != null
              ? Image.network(_event.imageUrl!, fit: BoxFit.cover)
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.calendarDay,
                      size: 64,
                      color: Colors.white24,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTitleAndHost(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _event.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                'O', // Placeholder for organizer initial
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organizer Name', // Placeholder
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _event.source ?? 'Organizer',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateTimeLocation(
    ThemeData theme,
    String dateString,
    String timeString,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoItem(
            theme,
            icon: FontAwesomeIcons.calendar,
            title: dateString,
            subtitle: timeString,
          ),
        ),
        Expanded(
          child: _buildInfoItem(
            theme,
            icon: FontAwesomeIcons.locationDot,
            title: _event.venueName,
            subtitle: _event.venueAddress ?? 'View on map',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _event.description ?? 'No description available.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendees(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendees (${_event.participantsCount})',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See All',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Placeholder
            itemBuilder: (context, index) {
              return Align(
                widthFactor: 0.7,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 2,
                    ),
                    color: theme.colorScheme.secondaryContainer,
                  ),
                  child: Center(
                    child: Text(
                      '+${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSecondaryContainer,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJoinButton(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _event.isAttending
              ? Colors.grey
              : theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          // ignore: deprecated_member_use
          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
        ),
        onPressed: _isLoading ? null : _toggleAttendance,
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                _event.isAttending ? 'Leave Event' : 'Join Event',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
