import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_state.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/fetch_repositories.dart';

class RepositoryCubit extends Cubit<RepositoryState> {
  final FetchRepositories fetchRepositories;
  int currentPage = 1;
  bool hasMore = true;

  RepositoryCubit({required this.fetchRepositories}) : super(RepositoryInitial());

  Future<void> loadRepositories() async {
    if (state is RepositoryLoading) return;

    emit(RepositoryLoading());
    final failureOrRepositories = await fetchRepositories(Params(page: currentPage, perPage: 10));
    failureOrRepositories.fold(
      (failure) => emit(RepositoryError(message: _mapFailureToMessage(failure))),
      (repositories) {
        if (repositories.isEmpty) {
          hasMore = false;
        } else {
          currentPage++;
        }
        emit(RepositoryLoaded(repositories: repositories));
      },
    );
  }

  Future<void>  refreshRepositories() async {
    currentPage = 1;
    hasMore = true;
    emit(RepositoryInitial());
    await loadRepositories();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      case  const (CacheFailure):
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
