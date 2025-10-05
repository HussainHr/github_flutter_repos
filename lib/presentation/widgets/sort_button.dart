import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/sort_option.dart';
import 'package:github_flutter_repos/presentation/providers/providers.dart';

class CustomShortButton extends ConsumerWidget {
  final Function(SortOption) onSortChanged;

  const CustomShortButton({
    super.key,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortState = ref.watch(sortNotifierProvider);

    return PopupMenuButton<SortOption>(
      icon: Icon(
        sortState.isAscending ? Icons.filter_list_alt : Icons.filter_list_alt,
      ),
      tooltip: HardCodedData.sortRepository,
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
              horizontalSpacing(12),
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
                horizontalSpacing(8),
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