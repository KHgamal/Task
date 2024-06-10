import 'package:flutter_task/core/constants/constants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/repository.dart';

abstract class RepositoryLocalDataSource {
  Future<void> cacheRepositories(List<Repository> repositories);
  Future<List<Repository>> getLastRepositories();
  Future<void> clearCache();
}

class RepositoryLocalDataSourceImpl implements RepositoryLocalDataSource {
  final Box<Repository> repositoryBox;

  RepositoryLocalDataSourceImpl(this.repositoryBox);

  @override
  Future<void> cacheRepositories(List<Repository> repositories) async {
    await repositoryBox.clear(); // Clear previous cache
    for (var repository in repositories) {
      await repositoryBox.put(repository.name, repository); // Use a unique key
    }
  }

  @override
  Future<List<Repository>> getLastRepositories() async {
    return repositoryBox.values.toList();
  }

  @override
  Future<void> clearCache() async {
    await repositoryBox.clear();
  }
}
