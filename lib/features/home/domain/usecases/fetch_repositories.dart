import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/repository.dart';
import '../repositories/repository_repository.dart';

class FetchRepositories implements UseCase<List<Repository>, Params> {
  final RepositoryRepository repository;

  FetchRepositories(this.repository);

  @override
  Future<Either<Failure, List<Repository>>> call(Params params) async {
    return await repository.fetchRepositories(params.page, params.perPage);
  }
}

class Params {
  final int page;
  final int perPage;

  Params({required this.page, required this.perPage});
}
