import 'package:json_annotation/json_annotation.dart';

part 'repository_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Repository {
  final int id;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  final Owner owner;
  final String? description;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @JsonKey(name: 'watchers_count')
  final int watchersCount;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @JsonKey(defaultValue: '')
  final String language;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'pushed_at')
  final DateTime? pushedAt;
  final int size;
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;
  final bool archived;
  final bool disabled;
  @JsonKey(name: 'default_branch')
  final String defaultBranch;

  const Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    this.pushedAt,
    required this.size,
    required this.openIssuesCount,
    required this.archived,
    required this.disabled,
    required this.defaultBranch,
  });

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Owner {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'gravatar_id', defaultValue: '')
  final String gravatarId;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String type;
  @JsonKey(name: 'site_admin')
  final bool siteAdmin;

  const Owner({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GitHubSearchResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;
  final List<Repository> items;

  const GitHubSearchResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory GitHubSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$GitHubSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubSearchResponseToJson(this);
}