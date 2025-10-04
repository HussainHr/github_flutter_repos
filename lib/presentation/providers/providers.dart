import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:github_flutter_repos/data/datasources/github_api_service.dart';
import 'package:github_flutter_repos/data/repositories/repository_repository.dart';
import 'repository_notifier.dart';
import 'theme_notifier.dart';
import 'sort_notifier.dart';

// API Service Provider
final gitHubApiServiceProvider = Provider<GitHubApiService>((ref) {
  return GitHubApiService();
});

// Repository Provider
final repositoryRepositoryProvider = Provider<RepositoryRepository>((ref) {
  final apiService = ref.watch(gitHubApiServiceProvider);
  return RepositoryRepository(apiService);
});

// Repository Notifier Provider
final repositoryNotifierProvider =
StateNotifierProvider<RepositoryNotifier, RepositoryState>((ref) {
  final repository = ref.watch(repositoryRepositoryProvider);
  return RepositoryNotifier(repository);
});

// Theme Notifier Provider
final themeNotifierProvider =
StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

// Sort Notifier Provider
final sortNotifierProvider =
StateNotifierProvider<SortNotifier, SortState>((ref) {
  return SortNotifier();
});