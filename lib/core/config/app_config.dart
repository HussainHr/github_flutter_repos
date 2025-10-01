import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String _environment;
  static late String _baseUrl;
  static late int _apiTimeout;
  static late bool _debugMode;

  static void initialize(String environment) {
    _environment = environment;
    _baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.github.com';
    _apiTimeout = int.parse(dotenv.env['API_TIMEOUT'] ?? '30000');
    _debugMode = dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  }

  static String get environment => _environment;
  static String get baseUrl => _baseUrl;
  static int get apiTimeout => _apiTimeout;
  static bool get debugMode => _debugMode;
  static bool get isDevelopment => _environment == 'dev';
  static bool get isProduction => _environment == 'prod';
}