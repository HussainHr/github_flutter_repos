import 'package:flutter/material.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';

class RepoStatsSection extends StatelessWidget {
  final Repository repository;

  const RepoStatsSection({
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
              HardCodedData.statistics,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpacing(16),
            Row(
              children: [
                Expanded(
                  child: _commonStatCard(
                    context,
                    HardCodedData.stars,
                    _formatNumber(repository.stargazersCount),
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                horizontalSpacing(8),
                Expanded(
                  child: _commonStatCard(
                    context,
                    HardCodedData.forks,
                    _formatNumber(repository.forksCount),
                    Icons.fork_right,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            verticalSpacing(8),
            Row(
              children: [
                Expanded(
                  child: _commonStatCard(
                    context,
                    HardCodedData.watchers,
                    _formatNumber(repository.watchersCount),
                    Icons.visibility,
                    Colors.green,
                  ),
                ),
                horizontalSpacing(8),
                Expanded(
                  child: _commonStatCard(
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

  Widget _commonStatCard(
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
          verticalSpacing(8),
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