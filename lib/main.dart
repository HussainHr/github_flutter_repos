import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_flutter_repos/presentation/app.dart';
import 'core/config/app_config.dart';
import 'core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configuration
  const String environment = String.fromEnvironment('ENV', defaultValue: 'dev');
  await dotenv.load(fileName: '.env.$environment');

  // Initialize app configuration
  AppConfig.initialize(environment);

  // Initialize database
  await DatabaseHelper.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
