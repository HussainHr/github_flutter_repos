import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_flutter_repos/presentation/providers/repository_notifier.dart';
import '../providers/providers.dart';
import '../widgets/repository_list_item.dart';
import '../widgets/sort_button.dart';
import '../widgets/theme_toggle_button.dart';
import 'repository_detail_page.dart';
import '../../domain/models/repository_model.dart';

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
        title: const Text('Flutter Repositories'),
        actions: [
          SortButton(
            onSortChanged: (sortOption) {
              ref.read(sortNotifierProvider.notifier)
                  .changeSortOption(sortOption);

              // Update repository state with newly sorted repositories
              final newSortedRepos = ref.read(sortNotifierProvider.notifier)
                  .sortRepositories(repositoryState.repositories);
              ref.read(repositoryNotifierProvider.notifier)
                  .sortRepositories(newSortedRepos);
            },
          ),
          const ThemeToggleButton(),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(context, ref, repositoryState, sortedRepositories),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(repositoryNotifierProvider.notifier).refreshRepositories(),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(
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
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(repositoryNotifierProvider.notifier).refreshRepositories(),
                child: const Text('Retry'),
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
            const SizedBox(height: 16),
            Text(
              'No repositories found',
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
