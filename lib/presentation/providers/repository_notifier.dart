import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:github_flutter_repos/data/repositories/repository_repository.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';

@immutable
class RepositoryState {
  final List<Repository> repositories;
  final bool isLoading;
  final String? error;
  final bool hasData;

  const RepositoryState({
    this.repositories = const [],
    this.isLoading = false,
    this.error,
    this.hasData = false,
  });

  RepositoryState copyWith({
    List<Repository>? repositories,
    bool? isLoading,
    String? error,
    bool? hasData,
  }) {
    return RepositoryState(
      repositories: repositories ?? this.repositories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasData: hasData ?? this.hasData,
    );
  }
}

class RepositoryNotifier extends StateNotifier<RepositoryState> {
  final RepositoryRepository _repository;

  RepositoryNotifier(this._repository) : super(const RepositoryState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repositories = await _repository.getRepositories();
      state = state.copyWith(
        repositories: repositories,
        isLoading: false,
        hasData: repositories.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshRepositories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repositories = await _repository.getRepositories(forceRefresh: true);
      state = state.copyWith(
        repositories: repositories,
        isLoading: false,
        hasData: repositories.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void sortRepositories(List<Repository> sortedRepositories) {
    state = state.copyWith(repositories: sortedRepositories);
  }
}