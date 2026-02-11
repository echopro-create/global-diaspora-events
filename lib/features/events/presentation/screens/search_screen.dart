import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../providers/events_providers.dart';
import '../../domain/entities/event.dart';
import '../widgets/event_card.dart';

/// Экран поиска событий.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsProvider(null));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    onChanged: (v) => setState(() => _query = v.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: 'Events, artists, venues...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: AppColors.textMuted,
                              ),
                              onPressed: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: eventsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (_, _) => const Center(
                  child: Text(
                    'Search unavailable',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                data: (events) {
                  final filtered = _filterEvents(events);

                  if (_query.isEmpty) {
                    return _buildSearchHint();
                  }

                  if (filtered.isEmpty) {
                    return _buildNoResults();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: filtered[index], onTap: () {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Event> _filterEvents(List<Event> events) {
    if (_query.isEmpty) return [];
    return events.where((e) {
      return e.title.toLowerCase().contains(_query) ||
          e.venueName.toLowerCase().contains(_query) ||
          e.description.toLowerCase().contains(_query) ||
          e.tags.any((t) => t.toLowerCase().contains(_query));
    }).toList();
  }

  Widget _buildSearchHint() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text(
            'Search for events',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Find concerts, festivals, exhibitions\nand more in your area',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords for "$_query"',
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
