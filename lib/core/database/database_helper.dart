import 'package:github_flutter_repos/core/constants/app_constants.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future initialize() async {
    await database;
  }

  static Future _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    // Create owners table
    await db.execute('''
      CREATE TABLE ${AppConstants.ownersTable} (
        id INTEGER PRIMARY KEY,
        login TEXT NOT NULL,
        avatar_url TEXT NOT NULL,
        gravatar_id TEXT NOT NULL,
        url TEXT NOT NULL,
        html_url TEXT NOT NULL,
        type TEXT NOT NULL,
        site_admin INTEGER NOT NULL
      )
    ''');

    // Create repositories table
    await db.execute('''
      CREATE TABLE ${AppConstants.repositoriesTable} (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        full_name TEXT NOT NULL,
        owner_id INTEGER NOT NULL,
        description TEXT,
        html_url TEXT NOT NULL,
        stargazers_count INTEGER NOT NULL,
        watchers_count INTEGER NOT NULL,
        forks_count INTEGER NOT NULL,
        language TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        pushed_at TEXT,
        size INTEGER NOT NULL,
        open_issues_count INTEGER NOT NULL,
        archived INTEGER NOT NULL,
        disabled INTEGER NOT NULL,
        default_branch TEXT NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES ${AppConstants.ownersTable} (id)
      )
    ''');
  }

  static Future insertRepositories(List repositories) async {
    final db = await database;
    await db.transaction((txn) async {
      // Clear existing data
      await txn.delete(AppConstants.repositoriesTable);
      await txn.delete(AppConstants.ownersTable);

      // Insert new data
      for (final repo in repositories) {
        // Insert owner first
        await txn.insert(
          AppConstants.ownersTable,
          {
            'id': repo.owner.id,
            'login': repo.owner.login,
            'avatar_url': repo.owner.avatarUrl,
            'gravatar_id': repo.owner.gravatarId,
            'url': repo.owner.url,
            'html_url': repo.owner.htmlUrl,
            'type': repo.owner.type,
            'site_admin': repo.owner.siteAdmin ? 1 : 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Insert repository
        await txn.insert(
          AppConstants.repositoriesTable,
          {
            'id': repo.id,
            'name': repo.name,
            'full_name': repo.fullName,
            'owner_id': repo.owner.id,
            'description': repo.description,
            'html_url': repo.htmlUrl,
            'stargazers_count': repo.stargazersCount,
            'watchers_count': repo.watchersCount,
            'forks_count': repo.forksCount,
            'language': repo.language,
            'created_at': repo.createdAt.toIso8601String(),
            'updated_at': repo.updatedAt.toIso8601String(),
            'pushed_at': repo.pushedAt?.toIso8601String(),
            'size': repo.size,
            'open_issues_count': repo.openIssuesCount,
            'archived': repo.archived ? 1 : 0,
            'disabled': repo.disabled ? 1 : 0,
            'default_branch': repo.defaultBranch,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static Future<List<Repository>> getRepositories() async {
    final db = await database;
    final List<Map> result = await db.rawQuery('''
      SELECT 
        r.*,
        o.login as owner_login,
        o.avatar_url as owner_avatar_url,
        o.gravatar_id as owner_gravatar_id,
        o.url as owner_url,
        o.html_url as owner_html_url,
        o.type as owner_type,
        o.site_admin as owner_site_admin
      FROM ${AppConstants.repositoriesTable} r
      JOIN ${AppConstants.ownersTable} o ON r.owner_id = o.id
    ''');

    return result.map((map) {
      return Repository(
        id: map['id'] as int,
        name: map['name'] as String,
        fullName: map['full_name'] as String,
        owner: Owner(
          id: map['owner_id'] as int,
          login: map['owner_login'] as String,
          avatarUrl: map['owner_avatar_url'] as String,
          gravatarId: map['owner_gravatar_id'] as String,
          url: map['owner_url'] as String,
          htmlUrl: map['owner_html_url'] as String,
          type: map['owner_type'] as String,
          siteAdmin: (map['owner_site_admin'] as int) == 1,
        ),
        description: map['description'] as String?,
        htmlUrl: map['html_url'] as String,
        stargazersCount: map['stargazers_count'] as int,
        watchersCount: map['watchers_count'] as int,
        forksCount: map['forks_count'] as int,
        language: map['language'] as String,
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
        pushedAt: map['pushed_at'] != null
            ? DateTime.parse(map['pushed_at'] as String)
            : null,
        size: map['size'] as int,
        openIssuesCount: map['open_issues_count'] as int,
        archived: (map['archived'] as int) == 1,
        disabled: (map['disabled'] as int) == 1,
        defaultBranch: map['default_branch'] as String,
      );
    }).toList();
  }

  static Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}