import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/repository.dart';
import '../../domain/repositories/repository_repository.dart';
import '../datasources/repository_remote_data_source.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDataSource remoteDataSource;

  RepositoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Repository>>> fetchRepositories(int page, int perPage) async {
    try {
      final repositories = await remoteDataSource.fetchRepositories(page, perPage);
      return Right(repositories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
