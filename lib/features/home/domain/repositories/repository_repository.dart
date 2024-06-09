import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/repository.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, List<Repository>>> fetchRepositories(int page, int perPage);
}
