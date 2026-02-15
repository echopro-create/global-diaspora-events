import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:global_diaspora_events/features/events/presentation/widgets/event_card_skeleton.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'package:global_diaspora_events/features/events/presentation/widgets/event_card.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';
import 'package:global_diaspora_events/features/events/domain/models/event_filter.dart';
import 'package:global_diaspora_events/features/events/presentation/widgets/search_filter_modal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final filterProvider = StateProvider<EventFilter?>((ref) => null);

final filteredEventsProvider = FutureProvider.autoDispose<List<Event>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final filter = ref.watch(filterProvider);
  return ref
      .watch(eventRepositoryProvider)
      .getEvents(searchQuery: searchQuery, filter: filter);
});

class EventsFeedScreen extends ConsumerStatefulWidget {
  const EventsFeedScreen({super.key});

  @override
  ConsumerState<EventsFeedScreen> createState() => _EventsFeedScreenState();
}

class _EventsFeedScreenState extends ConsumerState<EventsFeedScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsAsync = ref.watch(filteredEventsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final crossAxisCount = isWide
            ? (constraints.maxWidth / 350).floor()
            : 1;

        return Container(
          color: theme.colorScheme.surface,
          child: CustomScrollView(
            slivers: [
              _buildAppBar(theme, ref),
              _buildCategoryFilter(theme),
              _buildSectionHeader(theme, 'Recommended For You'),
              _buildRecommendedHorizontalList(theme),
              _buildSectionHeader(theme, 'Nearby Events'),
              eventsAsync.when(
                data: (events) {
                  if (isWide) {
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.8, // Adjust as needed
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final event = events[index];
                        return EventCard(
                              event: event,
                              onTap: () => context.push(
                                '/events/${event.id}',
                                extra: event,
                              ),
                            )
                            .animate(delay: (50 * index).ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.1, end: 0);
                      }, childCount: events.length),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final event = events[index];
                      return EventCard(
                            event: event,
                            onTap: () => context.push(
                              '/events/${event.id}',
                              extra: event,
                            ),
                          )
                          .animate(delay: (100 * index).ms)
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 400.ms,
                            curve: Curves.easeOutQuad,
                          );
                    }, childCount: events.length),
                  );
                },
                loading: () => isWide
                    ? SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const EventCardSkeleton(),
                          childCount: 6,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const EventCardSkeleton(),
                          childCount: 3,
                        ),
                      ),
                error: (err, stack) => SliverFillRemaining(
                  child: Center(child: Text('Error: $err')),
                ),
              ),
              // Add bottom padding to avoid content being hidden by nav bar
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(ThemeData theme, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 120, // Increased height for search bar
      floating: true,
      pinned: true,
      backgroundColor: theme.colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        background: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 50,
            bottom: 60,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Global Diaspora',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.circleUser, size: 24),
                onPressed: () {}, // Profile navigation
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search events...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const SearchFilterModal(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(ThemeData theme) {
    final categories = [
      'All',
      'Concerts',
      'Stand-up',
      'Business',
      'Sports',
      'Kids',
    ];
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (val) =>
                    setState(() => selectedCategory = category),
                backgroundColor: Colors.transparent,
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedHorizontalList(ThemeData theme) {
    final recommendedEventsAsync = ref.watch(recommendedEventsProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: recommendedEventsAsync.when(
          data: (events) {
            if (events.isEmpty) {
              return Center(
                child: Text(
                  'No recommended events yet',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () {
                    // Navigation to detail screen to be implemented
                  },
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: event.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(event.imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: event.imageUrl == null
                          ? LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                            )
                          : null,
                    ),
                    child: Stack(
                      children: [
                        if (event.imageUrl != null)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.calendar,
                                    color: Colors.white70,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    // Use intl for formatting in production
                                    event.dateStart.toString().split(' ')[0],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
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
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

// In event_providers.dart, we need to add the actual data fetching provider
// I'll update that in the next step.
