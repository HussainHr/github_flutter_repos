import 'package:flutter/material.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            _buildOwnerSection(context),
            const SizedBox(height: 24),
            _buildRepositoryInfoSection(context),
            const SizedBox(height: 24),
            _buildStatsSection(context),
            const SizedBox(height: 24),
            _buildDescriptionSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: CachedNetworkImageProvider(
                repository.owner.avatarUrl,
              ),
              onBackgroundImageError: (_, __) {},
              child: repository.owner.avatarUrl.isEmpty
                  ? Text(
                repository.owner.login[0].toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium,
              )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.owner.login,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      repository.owner.type,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepositoryInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HardCodedData.repositoryInformation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              HardCodedData.fullName,
              repository.fullName,
              Icons.folder_outlined,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              HardCodedData.language,
              repository.language.isNotEmpty ? repository.language : HardCodedData.notSpecified,
              Icons.code,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              HardCodedData.defaultBranch,
              repository.defaultBranch,
              Icons.merge_type,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              HardCodedData.lastUpdated,
              DateFormat('MM-dd-yyyy HH:mm').format(repository.updatedAt),
              Icons.update,
            ),
            if (repository.pushedAt != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                HardCodedData.lastPush,
                DateFormat('MM-dd-yyyy HH:mm').format(repository.pushedAt!),
                Icons.publish,
              ),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              HardCodedData.created,
              DateFormat('MM-dd-yyyy HH:mm').format(repository.createdAt),
              Icons.calendar_today,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HardCodedData.statistics,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    HardCodedData.stars,
                    _formatNumber(repository.stargazersCount),
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    context,
                    HardCodedData.forks,
                    _formatNumber(repository.forksCount),
                    Icons.fork_right,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    HardCodedData.watchers,
                    _formatNumber(repository.watchersCount),
                    Icons.visibility,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    context,
                    HardCodedData.issues,
                    _formatNumber(repository.openIssuesCount),
                    Icons.bug_report,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    if (repository.description == null || repository.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HardCodedData.description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              repository.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}