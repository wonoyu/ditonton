part of 'movies_search_bloc.dart';

enum MoviesSearchStatus { initial, loading, loaded, error }

class MoviesSearchState extends Equatable {
  const MoviesSearchState({
    this.status = MoviesSearchStatus.initial,
    this.searchResult = const <Movie>[],
    this.message = 'Empty',
  });

  final MoviesSearchStatus status;
  final List<Movie> searchResult;
  final String message;

  MoviesSearchState copyWith({
    MoviesSearchStatus Function()? status,
    List<Movie> Function()? searchResult,
    String Function()? message,
  }) {
    return MoviesSearchState(
      status: status != null ? status() : this.status,
      searchResult: searchResult != null ? searchResult() : this.searchResult,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, searchResult, message];
}
