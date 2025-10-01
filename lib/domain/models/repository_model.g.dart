// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) => Repository(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  fullName: json['full_name'] as String,
  owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
  description: json['description'] as String?,
  htmlUrl: json['html_url'] as String,
  stargazersCount: (json['stargazers_count'] as num).toInt(),
  watchersCount: (json['watchers_count'] as num).toInt(),
  forksCount: (json['forks_count'] as num).toInt(),
  language: json['language'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  pushedAt: json['pushed_at'] == null
      ? null
      : DateTime.parse(json['pushed_at'] as String),
  size: (json['size'] as num).toInt(),
  openIssuesCount: (json['open_issues_count'] as num).toInt(),
  archived: json['archived'] as bool,
  disabled: json['disabled'] as bool,
  defaultBranch: json['default_branch'] as String,
);

Map<String, dynamic> _$RepositoryToJson(Repository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner.toJson(),
      'description': instance.description,
      'html_url': instance.htmlUrl,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'language': instance.language,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'pushed_at': instance.pushedAt?.toIso8601String(),
      'size': instance.size,
      'open_issues_count': instance.openIssuesCount,
      'archived': instance.archived,
      'disabled': instance.disabled,
      'default_branch': instance.defaultBranch,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
  gravatarId: json['gravatar_id'] as String? ?? '',
  url: json['url'] as String,
  htmlUrl: json['html_url'] as String,
  type: json['type'] as String,
  siteAdmin: json['site_admin'] as bool,
);

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
  'gravatar_id': instance.gravatarId,
  'url': instance.url,
  'html_url': instance.htmlUrl,
  'type': instance.type,
  'site_admin': instance.siteAdmin,
};

GitHubSearchResponse _$GitHubSearchResponseFromJson(
  Map<String, dynamic> json,
) => GitHubSearchResponse(
  totalCount: (json['total_count'] as num).toInt(),
  incompleteResults: json['incomplete_results'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => Repository.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GitHubSearchResponseToJson(
  GitHubSearchResponse instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
