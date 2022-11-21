part of 'movies_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, loaded, error }

class MoviesDetailState extends Equatable {
  const MoviesDetailState({
    this.status = MovieDetailStatus.initial,
    this.movie,
    this.message = 'Empty',
  });

  final MovieDetailStatus status;
  final MovieDetail? movie;
  final String message;

  MoviesDetailState copyWith({
    MovieDetailStatus Function()? status,
    MovieDetail? Function()? movie,
    String Function()? message,
  }) {
    return MoviesDetailState(
      status: status != null ? status() : this.status,
      movie: movie != null ? movie() : this.movie,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, movie, message];
}
