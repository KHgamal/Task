import 'package:hive/hive.dart';
import '../models/repository_model.dart';

abstract class RepositoryLocalDataSource {
  Future<void> cacheRepositories(List<RepositoryModel> repositories);
  Future<List<RepositoryModel>> getLastRepositories();
  Future<void> clearCache();
}

class RepositoryLocalDataSourceImpl implements RepositoryLocalDataSource {
  final Box repositoryBox;

  RepositoryLocalDataSourceImpl(this.repositoryBox);

  @override
  Future<void> cacheRepositories(List<RepositoryModel> repositories) async {
    await repositoryBox.put('cached_repositories', repositories);
  }

  @override
  Future<List<RepositoryModel>> getLastRepositories() async {
    final cachedRepositories = repositoryBox.get('cached_repositories');
    if (cachedRepositories != null) {
      return List<RepositoryModel>.from(cachedRepositories);
    }
    return [];
  }

  @override
  Future<void> clearCache() async {
    await repositoryBox.clear();
  }
}
