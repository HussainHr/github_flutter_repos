import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_flutter_repos/core/constants/hard_coded_data.dart';
import 'package:github_flutter_repos/core/utils/app_spacing.dart';
import 'package:github_flutter_repos/domain/models/repository_model.dart';
import 'package:github_flutter_repos/presentation/pages/repository_detail_page.dart';
import 'package:github_flutter_repos/presentation/providers/providers.dart';
import 'package:github_flutter_repos/presentation/providers/repository_notifier.dart';
import 'package:github_flutter_repos/presentation/widgets/repository_list_item.dart';
import 'package:github_flutter_repos/presentation/widgets/sort_button.dart';
import 'package:github_flutter_repos/presentation/widgets/theme_toggle_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryState = ref.watch(repositoryNotifierProvider);
    final sortState = ref.watch(sortNotifierProvider);

    // Sort repositories based on current sort state
    final sortedRepositories = ref.read(sortNotifierProvider.notifier)
        .sortRepositories(repositoryState.repositories);

    return Scaffold(
      appBar: AppBar(
        title: Text(HardCodedData.flutterRepository),
        actions: [
          CustomShortButton(
            onSortChanged: (sortOption) {
              ref.read(sortNotifierProvider.notifier).changeSortOption(sortOption);

              // Update repository state with newly sorted repositories
              final newSortedRepos = ref.read(sortNotifierProvider.notifier).sortRepositories(repositoryState.repositories);
              ref.read(repositoryNotifierProvider.notifier).sortRepositories(newSortedRepos);
            },
          ),
          const ThemeToggleButton(),
          horizontalSpacing(8),
        ],
      ),
      body: _homePageBody(context, ref, repositoryState, sortedRepositories),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(repositoryNotifierProvider.notifier).refreshRepositories(),
        tooltip: HardCodedData.refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _homePageBody(
      BuildContext context,
      WidgetRef ref,
      RepositoryState state,
      List<Repository> repositories,
      ) {
    if (state.isLoading && !state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null && !state.hasData) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              verticalSpacing(16),
              Text(
                HardCodedData.error,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              verticalSpacing(8),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              verticalSpacing(16),
              ElevatedButton(
                onPressed: () => ref.read(repositoryNotifierProvider.notifier).refreshRepositories(),
                child: const Text(HardCodedData.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (repositories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            verticalSpacing(16),
            Text(
              HardCodedData.noRepoFound,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(repositoryNotifierProvider.notifier).refreshRepositories(),
      child: Column(
        children: [
          if (state.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Text(
                state.error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repository = repositories[index];
                return RepositoryListItem(
                  repository: repository,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepositoryDetailPage(
                          repository: repository,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
