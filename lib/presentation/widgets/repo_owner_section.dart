import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';

class RepoOwnerSection extends StatelessWidget {
  final Repository repository;

  const RepoOwnerSection({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
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
            horizontalSpacing(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.owner.login,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  verticalSpacing(4),
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
}