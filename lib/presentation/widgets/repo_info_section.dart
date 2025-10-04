import 'package:flutter/material.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:intl/intl.dart';

class RepositoryInfoSection extends StatelessWidget {
  final Repository repository;

  const RepositoryInfoSection({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
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
            verticalSpacing(16),
            _buildInfoRow(
              context,
              HardCodedData.fullName,
              repository.fullName,
              Icons.folder_outlined,
            ),
            verticalSpacing(12),
            _buildInfoRow(
              context,
              HardCodedData.language,
              repository.language.isNotEmpty ? repository.language : HardCodedData.notSpecified,
              Icons.code,
            ),
            verticalSpacing(12),
            _buildInfoRow(
              context,
              HardCodedData.defaultBranch,
              repository.defaultBranch,
              Icons.merge_type,
            ),
            verticalSpacing(12),
            _buildInfoRow(
              context,
              HardCodedData.lastUpdated,
              DateFormat('MM-dd-yyyy HH:mm').format(repository.updatedAt),
              Icons.update,
            ),
            if (repository.pushedAt != null) ...[
              verticalSpacing(12),
              _buildInfoRow(
                context,
                HardCodedData.lastPush,
                DateFormat('MM-dd-yyyy HH:mm').format(repository.pushedAt!),
                Icons.publish,
              ),
            ],
            verticalSpacing(12),
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
        horizontalSpacing(16),
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
}