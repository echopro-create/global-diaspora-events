import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/events/events_providers.dart';
import 'package:global_diaspora_events/src/features/events/widgets/event_card.dart';
import 'package:global_diaspora_events/src/features/events/widgets/tags_filter.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';
import 'package:go_router/go_router.dart';

class EventsFeedScreen extends ConsumerStatefulWidget {
  const EventsFeedScreen({super.key});

  @override
  ConsumerState<EventsFeedScreen> createState() => _EventsFeedScreenState();
}

class _EventsFeedScreenState extends ConsumerState<EventsFeedScreen> {
  final List<String> _selectedTagIds = [];

  void _onTagTap(String tagId) {
    setState(() {
      if (_selectedTagIds.contains(tagId)) {
        _selectedTagIds.remove(tagId);
      } else {
        _selectedTagIds.add(tagId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final promotedAsync = ref.watch(promotedEventsProvider);
    final nearbyAsync = ref.watch(nearbyEventsProvider);
    final personalizedAsync = ref.watch(personalizedEventsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/suggest-event'),
        label: const Text('Предложить'),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'Global Diaspora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TagsFilter(
                  selectedTagIds: _selectedTagIds,
                  onTagTap: _onTagTap,
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Тренды'),
                const SizedBox(height: 12),
                _buildHorizontalSection(promotedAsync),
                const SizedBox(height: 32),
                _buildSectionHeader('Для вас'),
                const SizedBox(height: 12),
                _buildHorizontalSection(personalizedAsync),
                const SizedBox(height: 32),
                _buildSectionHeader('События рядом'),
                const SizedBox(height: 12),
              ],
            ),
          ),
          nearbyAsync.when(
            data: (events) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => EventCard(
                    event: events[index],
                    onTap: () => context.push('/event/${events[index].id}'),
                    onJoinTap: () {},
                  ),
                  childCount: events.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) =>
                SliverFillRemaining(child: Center(child: Text('Ошибка: $e'))),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalSection(AsyncValue<List<Event>> asyncData) {
    return SizedBox(
      height: 250,
      child: asyncData.when(
        data: (events) => events.isEmpty
            ? const Center(child: Text('Нет событий по вашим интересам'))
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: _buildShortCard(context, events[index]),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }

  Widget _buildShortCard(BuildContext context, Event event) {
    return GestureDetector(
      onTap: () => context.push('/event/${event.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  image: event.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(event.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: event.imageUrl == null
                    ? const Center(child: Icon(Icons.event, size: 40))
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.address ?? 'Адрес не указан',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
