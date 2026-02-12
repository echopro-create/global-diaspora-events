import 'package:flutter/material.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';
import '../../../../core/widgets/shimmer_skeletons.dart';
import '../../../categories/presentation/providers/categories_providers.dart';
import '../providers/events_providers.dart';
import '../../../../core/providers/location_providers.dart';
import '../widgets/event_card.dart';
import '../widgets/hero_carousel.dart';

/// Главный экран — лента событий с сегментацией.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String? _selectedCategoryId;

  static const _tabCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabCount, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundDark,
              AppColors.primary.withValues(alpha: 0.05),
              AppColors.secondary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.discoverEvents,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.discoverSubtitle,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Карта
                          GestureDetector(
                            onTap: () => context.push('/map'),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.map_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Аватар — тап → профиль
                          GestureDetector(
                            onTap: () => context.go('/profile'),
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.primary,
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Поиск → переход на Search Tab
                      GestureDetector(
                        onTap: () => context.go('/search'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cardDark,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: AppColors.textMuted,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                AppLocalizations.of(context)!.searchHint,
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Табы
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textMuted,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.forYou),
                      Tab(text: AppLocalizations.of(context)!.nearby),
                      Tab(text: AppLocalizations.of(context)!.categories),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildForYouTab(),
                _buildNearbyTab(),
                _buildCategoriesTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForYouTab() {
    final eventsAsync = ref.watch(eventsProvider(null));

    return eventsAsync.when(
      loading: () => const EventListSkeleton(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.failedToLoad,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(eventsProvider(null)),
              child: Text(AppLocalizations.of(context)!.tryAgain),
            ),
          ],
        ),
      ),
      data: (events) {
        if (events.isEmpty) {
          return _buildEmptyState();
        }
        final featuredEvents = events.take(3).toList();
        final otherEvents = events.skip(3).toList();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider(null));
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: 1 + otherEvents.length, // 1 for Carousel
            itemBuilder: (context, index) {
              if (index == 0) {
                if (featuredEvents.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: Text(
                          AppLocalizations.of(context)!.featuredEvents,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      HeroCarousel(
                        events: featuredEvents,
                        onTap: (event) => context.push('/event/${event.id}'),
                      ),
                      const SizedBox(height: 24),
                      if (otherEvents.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLocalizations.of(context)!.allEvents,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }

              final event = otherEvents[index - 1];
              return EventCard(
                event: event,
                onTap: () => context.push('/event/${event.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNearbyTab() {
    final positionAsync = ref.watch(currentPositionProvider);

    return positionAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        // Permission denied or location services disabled
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.location_off_rounded,
                    size: 48,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.eventsNearYou,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.enableLocationHint,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(currentPositionProvider);
                  },
                  icon: const Icon(Icons.my_location_rounded),
                  label: Text(AppLocalizations.of(context)!.enableLocation),
                ),
              ],
            ),
          ),
        );
      },
      data: (position) {
        if (position == null) {
          // User denied permission — show prompt again
          return Center(
            child: ElevatedButton.icon(
              onPressed: () => ref.invalidate(currentPositionProvider),
              icon: const Icon(Icons.my_location_rounded),
              label: Text(AppLocalizations.of(context)!.enableLocation),
            ),
          );
        }
        final nearbyAsync = ref.watch(
          nearbyEventsProvider((
            lat: position.latitude,
            lng: position.longitude,
            radius: 50.0,
          )),
        );

        return nearbyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text(
              AppLocalizations.of(context)!.failedToLoad,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          data: (events) {
            if (events.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.noNearbyEvents(50),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                  onTap: () => context.push('/event/${event.id}'),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildCategoriesTab() {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => const CategoryChipsSkeleton(),
      error: (_, _) => Center(
        child: Text(
          AppLocalizations.of(context)!.failedToLoadCategories,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
      data: (categories) {
        return Column(
          children: [
            // Горизонтальная полоска категорий
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: categories.length + 1, // +1 для "All"
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final isSelected = isAll
                      ? _selectedCategoryId == null
                      : _selectedCategoryId == categories[index - 1].id;

                  final label = isAll
                      ? AppLocalizations.of(context)!.all
                      : categories[index - 1].name;
                  final icon = isAll
                      ? '🌍'
                      : (categories[index - 1].icon ?? '📋');

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = isAll
                            ? null
                            : categories[index - 1].id;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.cardDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(icon, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Список событий фильтрованный по категории
            Expanded(child: _buildCategoryEvents()),
          ],
        );
      },
    );
  }

  Widget _buildCategoryEvents() {
    final eventsAsync = ref.watch(eventsProvider(_selectedCategoryId));

    return eventsAsync.when(
      loading: () => const EventListSkeleton(),
      error: (_, _) => Center(
        child: Text(
          AppLocalizations.of(context)!.failedToLoad,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
      data: (events) {
        if (events.isEmpty) return _buildEmptyState();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider(_selectedCategoryId));
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                onTap: () => context.push('/event/${event.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.event_busy_rounded,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noEventsYet,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.checkBackLater,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Делегат для закреплённого TabBar.
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.backgroundDark, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}
