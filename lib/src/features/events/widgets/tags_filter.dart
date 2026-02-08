import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/events/events_providers.dart';

class TagsFilter extends ConsumerWidget {
  final List<String> selectedTagIds;
  final ValueChanged<String> onTagTap;

  const TagsFilter({
    super.key,
    required this.selectedTagIds,
    required this.onTagTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider);

    return tagsAsync.when(
      data: (tags) => SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tags.length,
          itemBuilder: (context, index) {
            final tag = tags[index];
            final isSelected = selectedTagIds.contains(tag.id);

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(tag.name),
                selected: isSelected,
                onSelected: (_) => onTagTap(tag.id),
                backgroundColor: Colors.white10,
                selectedColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: isSelected
                    ? BorderSide.none
                    : const BorderSide(color: Colors.white24),
              ),
            );
          },
        ),
      ),
      loading: () => const SizedBox(height: 40),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}
