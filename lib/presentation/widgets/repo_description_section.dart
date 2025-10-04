import 'package:flutter/material.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';

class RepoDescriptionSection extends StatelessWidget {
  final Repository repository;

  const RepoDescriptionSection({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
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
            verticalSpacing(16),
            Text(
              repository.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}