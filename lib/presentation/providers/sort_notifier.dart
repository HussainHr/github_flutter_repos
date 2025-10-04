import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:github_flutter_repos/core/constants/app_constants.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:github_flutter_repos/domain/models/sort_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SortState {
  final SortOption currentSort;
  final bool isAscending;

  const SortState({
    this.currentSort = SortOption.starCount,
    this.isAscending = false,
  });

  SortState copyWith({
    SortOption? currentSort,
    bool? isAscending,
  }) {
    return SortState(
      currentSort: currentSort ?? this.currentSort,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}

class SortNotifier extends StateNotifier<SortState> {
  SortNotifier() : super(const SortState()) {
    _loadSortPreferences();
  }

  Future<void> _loadSortPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sortOptionKey = prefs.getString(AppConstants.sortOptionKey) ??
          SortOption.starCount.key;
      final isAscending = prefs.getBool(AppConstants.sortOrderKey) ?? false;

      final sortOption = SortOption.values.firstWhere(
            (option) => option.key == sortOptionKey,
        orElse: () => SortOption.starCount,
      );

      state = SortState(
        currentSort: sortOption,
        isAscending: isAscending,
      );
    } catch (e) {
      // If loading fails, keep default sort
    }
  }

  Future<void> _saveSortPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.sortOptionKey, state.currentSort.key);
      await prefs.setBool(AppConstants.sortOrderKey, state.isAscending);
    } catch (e) {
      // If saving fails, continue with current state
    }
  }

  void changeSortOption(SortOption sortOption) {
    if (state.currentSort == sortOption) {
      // Toggle sort order
      state = state.copyWith(isAscending: !state.isAscending);
    } else {
      // Change sort option and reset to descending
      state = state.copyWith(
        currentSort: sortOption,
        isAscending: false,
      );
    }
    _saveSortPreferences();
  }

  List<Repository> sortRepositories(List<Repository> repositories) {
    final sortedRepos = List<Repository>.from(repositories);

    switch (state.currentSort) {
      case SortOption.starCount:
        sortedRepos.sort((a, b) => state.isAscending
            ? a.stargazersCount.compareTo(b.stargazersCount)
            : b.stargazersCount.compareTo(a.stargazersCount));
        break;
      case SortOption.lastUpdated:
        sortedRepos.sort((a, b) => state.isAscending
            ? a.updatedAt.compareTo(b.updatedAt)
            : b.updatedAt.compareTo(a.updatedAt));
        break;
    }

    return sortedRepos;
  }
}