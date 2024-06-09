import '../../../domain/entities/repository.dart';

abstract class RepositoryState {}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final List<Repository> repositories;

  RepositoryLoaded({required this.repositories});
}

class RepositoryError extends RepositoryState {
  final String message;

  RepositoryError({required this.message});
}
