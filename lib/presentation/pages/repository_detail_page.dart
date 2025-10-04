import 'package:flutter/material.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:github_flutter_repos/presentation/widgets/repo_description_section.dart';
import 'package:github_flutter_repos/presentation/widgets/repo_info_section.dart';
import 'package:github_flutter_repos/presentation/widgets/repo_owner_section.dart';
import 'package:github_flutter_repos/presentation/widgets/repo_stat_section.dart';

class RepositoryDetailPage extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: HardCodedData.openGithub,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${HardCodedData.openGithub}: ${repository.htmlUrl}'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepoOwnerSection(repository: repository),
            verticalSpacing(24),
            RepositoryInfoSection(repository: repository),
            verticalSpacing(24),
            RepoStatsSection(repository: repository),
            verticalSpacing(24),
            RepoDescriptionSection(repository: repository),
          ],
        ),
      ),
    );
  }
}