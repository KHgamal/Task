import '../../../domain/entities/repository.dart';

abstract class RepositoryState {
  List<Repository> get repositories;
  bool get hasMore;
}

class RepositoryInitial extends RepositoryState {
  @override
  List<Repository> get repositories => [];

  @override
  bool get hasMore => true;
}

class RepositoryLoading extends RepositoryState {
  final List<Repository> _repositories;
  final bool _hasMore;

  RepositoryLoading(this._repositories, this._hasMore);

  @override
  List<Repository> get repositories => _repositories;

  @override
  bool get hasMore => _hasMore;
}

class RepositoryLoaded extends RepositoryState {
  final List<Repository> _repositories;
  final bool _hasMore;

  RepositoryLoaded({required List<Repository> repositories, required bool hasMore})
      : _repositories = repositories,
        _hasMore = hasMore;

  @override
  List<Repository> get repositories => _repositories;

  @override
  bool get hasMore => _hasMore;
}

class RepositoryError extends RepositoryState {
  final String message;
  final List<Repository> _repositories;
  final bool _hasMore;

  RepositoryError({required this.message, required List<Repository> repositories})
      : _repositories = repositories,
        _hasMore = false;

  @override
  List<Repository> get repositories => _repositories;

  @override
  bool get hasMore => _hasMore;
}
