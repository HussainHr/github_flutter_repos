import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../../domain/models/sort_option.dart';

class SortButton extends ConsumerWidget {
  final Function(SortOption) onSortChanged;

  const SortButton({
    super.key,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortState = ref.watch(sortNotifierProvider);

    return PopupMenuButton<SortOption>(
      icon: Icon(
        sortState.isAscending ? Icons.arrow_upward : Icons.arrow_downward,
      ),
      tooltip: 'Sort repositories',
      onSelected: onSortChanged,
      itemBuilder: (context) => SortOption.values.map((option) {
        final isSelected = sortState.currentSort == option;
        return PopupMenuItem<SortOption>(
          value: option,
          child: Row(
            children: [
              Icon(
                _getIconForSortOption(option),
                size: 20,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option.displayName,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    fontWeight: isSelected ? FontWeight.w600 : null,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Icon(
                  sortState.isAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getIconForSortOption(SortOption option) {
    switch (option) {
      case SortOption.starCount:
        return Icons.star;
      case SortOption.lastUpdated:
        return Icons.update;
    }
  }
}