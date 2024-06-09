import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/repository.dart';
import '../../domain/repositories/repository_repository.dart';
import '../datasources/repository_local_data_source.dart';
import '../datasources/repository_remote_data_source.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDataSource remoteDataSource;
   final RepositoryLocalDataSource localDataSource;

  RepositoryRepositoryImpl({required this.localDataSource, required this.remoteDataSource});

  @override
 Future<Either<Failure, List<Repository>>> fetchRepositories(int page, int perPage) async {
    if (page == 1) {
      try {
        final localRepositories = await localDataSource.getLastRepositories();
        if (localRepositories.isNotEmpty) {
          return Right(localRepositories);
        }
      } catch (_) {
        // Ignore local cache errors
      }
    }

    try {
      final remoteRepositories = await remoteDataSource.fetchRepositories(page, perPage);
      if (page == 1) {
        localDataSource.cacheRepositories(remoteRepositories);
      }
      return Right(remoteRepositories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
