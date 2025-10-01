enum SortOption {
  starCount,
  lastUpdated,
}

extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.starCount:
        return 'Stars';
      case SortOption.lastUpdated:
        return 'Last Updated';
    }
  }

  String get key {
    switch (this) {
      case SortOption.starCount:
        return 'star_count';
      case SortOption.lastUpdated:
        return 'last_updated';
    }
  }
}