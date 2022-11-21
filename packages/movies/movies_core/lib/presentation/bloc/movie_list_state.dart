part of 'movie_list_bloc.dart';

enum MovieListStatus { initial, loading, loaded, error }

class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState({
    this.status = MovieListStatus.initial,
    this.movies = const <Movie>[],
    this.message = 'Empty',
  });

  final MovieListStatus status;
  final List<Movie> movies;
  final String message;

  NowPlayingMoviesState copyWith({
    MovieListStatus Function()? status,
    List<Movie> Function()? movies,
    String Function()? message,
  }) {
    return NowPlayingMoviesState(
      status: status != null ? status() : this.status,
      movies: movies != null ? movies() : this.movies,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, movies, message];
}

class PopularMoviesState extends Equatable {
  const PopularMoviesState({
    this.status = MovieListStatus.initial,
    this.movies = const <Movie>[],
    this.message = 'Empty',
  });

  final MovieListStatus status;
  final List<Movie> movies;
  final String message;

  PopularMoviesState copyWith({
    MovieListStatus Function()? status,
    List<Movie> Function()? movies,
    String Function()? message,
  }) {
    return PopularMoviesState(
      status: status != null ? status() : this.status,
      movies: movies != null ? movies() : this.movies,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, movies, message];
}

class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState({
    this.status = MovieListStatus.initial,
    this.movies = const <Movie>[],
    this.message = 'Empty',
  });

  final MovieListStatus status;
  final List<Movie> movies;
  final String message;

  TopRatedMoviesState copyWith({
    MovieListStatus Function()? status,
    List<Movie> Function()? movies,
    String Function()? message,
  }) {
    return TopRatedMoviesState(
      status: status != null ? status() : this.status,
      movies: movies != null ? movies() : this.movies,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, movies, message];
}
