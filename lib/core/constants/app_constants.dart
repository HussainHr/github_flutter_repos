class AppConstants {
  // API Constants
  static const String searchQuery = 'Flutter';
  static const int repositoriesPerPage = 50;

  // Storage Keys
  static const String themeModeKey = 'theme_mode';
  static const String sortOptionKey = 'sort_option';
  static const String sortOrderKey = 'sort_order';

  // Database
  static const String databaseName = 'github_repos.db';
  static const int databaseVersion = 1;
  static const String repositoriesTable = 'repositories';
  static const String ownersTable = 'owners';
}