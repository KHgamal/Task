import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_state.dart';
import '../../../../../core/error/failure.dart';

import '../../../domain/entities/repository.dart';
import '../../../domain/usecases/fetch_repositories.dart';

class RepositoryCubit extends Cubit<RepositoryState> {
  final FetchRepositories fetchRepositories;

  RepositoryCubit({required this.fetchRepositories}) : super(RepositoryInitial());

  int _page = 1;
  final int _perPage = 10;
  bool _hasMore = true;
  List<Repository> _repositories = [];
  List<Repository> _filteredRepositories = [];
  bool get hasMore => _hasMore;
  List<Repository> get repositories => _repositories;
  List<Repository> get filteredRepositories => _filteredRepositories;

  Future<void> loadRepositories() async {
    if (state is RepositoryLoading) return;
    emit(RepositoryLoading(_repositories, _hasMore));

    final Either<Failure, List<Repository>> result = await fetchRepositories.call(Params(page: _page, perPage: _perPage));

    result.fold(
      (failure) => emit(RepositoryError(message: _mapFailureToMessage(failure), repositories: _repositories)),
      (repositories) {
        _repositories.addAll(repositories);
        _filteredRepositories = List.from(_repositories);
        _page++;
        _hasMore = repositories.length == _perPage;
        emit(RepositoryLoaded(repositories: _filteredRepositories, hasMore: _hasMore));
      },
    );
  }

  Future<void> refreshRepositories() async {
    _page = 1;
    _repositories.clear();
    _filteredRepositories.clear();
    _hasMore = true;
    await loadRepositories();
  }

  void filterRepositories(String query) {
    if (query.isEmpty) {
      _filteredRepositories = List.from(_repositories);
    } else {
      _filteredRepositories = _repositories.where((repo) => repo.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    emit(RepositoryLoaded(repositories: _filteredRepositories, hasMore: _hasMore));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      case const (CacheFailure):
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
