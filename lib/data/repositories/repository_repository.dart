import 'package:github_flutter_repos/core/database/database_helper.dart';
import 'package:github_flutter_repos/data/datasources/github_api_service.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';

class RepositoryRepository {
  final GitHubApiService _apiService;

  RepositoryRepository(this._apiService);

  Future<List<Repository>> getRepositories({bool forceRefresh = false}) async {
    if (forceRefresh) {
      try {
        final repositories = await _apiService.searchFlutterRepositories();
        await DatabaseHelper.insertRepositories(repositories);
        return repositories;
      } catch (e) {
        // If API call fails, try to return cached data
        final cachedRepos = await DatabaseHelper.getRepositories();
        if (cachedRepos.isNotEmpty) {
          return cachedRepos;
        }
        rethrow;
      }
    } else {
      // Try to get cached data first
      final cachedRepos = await DatabaseHelper.getRepositories();
      if (cachedRepos.isNotEmpty) {
        return cachedRepos;
      }

      // If no cached data, fetch from API
      try {
        final repositories = await _apiService.searchFlutterRepositories();
        await DatabaseHelper.insertRepositories(repositories);
        return repositories;
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List> getCachedRepositories() async {
    return await DatabaseHelper.getRepositories();
  }
}