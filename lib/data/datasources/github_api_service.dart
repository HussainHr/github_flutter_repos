import 'package:dio/dio.dart';
import '../../core/config/app_config.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/repository_model.dart';

class GitHubApiService {
  late final Dio _dio;

  GitHubApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: Duration(milliseconds: AppConfig.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConfig.apiTimeout),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'User-Agent': 'GitHubFlutterRepos',
      },
    ));

    if (AppConfig.debugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ));
    }
  }

  Future<List<Repository>> searchFlutterRepositories() async {
    try {
      final response = await _dio.get(
        '/search/repositories',
        queryParameters: {
          'q': AppConstants.searchQuery,
          'sort': 'stars',
          'order': 'desc',
          'per_page': AppConstants.repositoriesPerPage,
        },
      );

      if (response.statusCode == 200) {
        // Ensure the data is properly cast to Map<String, dynamic>
        final Map<String, dynamic> data = Map<String, dynamic>.from(
          response.data as Map,
        );
        final searchResponse = GitHubSearchResponse.fromJson(data);
        return searchResponse.items;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to fetch repositories',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network settings.');
      } else if (e.response?.statusCode == 403) {
        throw Exception('API rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to fetch repositories: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}