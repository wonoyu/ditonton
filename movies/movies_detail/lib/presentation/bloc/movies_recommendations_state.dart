part of 'movies_recommendations_bloc.dart';

class MoviesRecommendationsState extends Equatable {
  const MoviesRecommendationsState({
    this.status = MovieDetailStatus.initial,
    this.movie = const [],
    this.message = 'Empty',
  });

  final MovieDetailStatus status;
  final List<Movie> movie;
  final String message;

  MoviesRecommendationsState copyWith({
    MovieDetailStatus Function()? status,
    List<Movie> Function()? movie,
    String Function()? message,
  }) {
    return MoviesRecommendationsState(
      status: status != null ? status() : this.status,
      movie: movie != null ? movie() : this.movie,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, movie, message];
}
