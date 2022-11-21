part of 'watchlist_movies_bloc.dart';

enum WatchlistMoviesStatus { initial, loading, loaded, error }

class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState({
    this.status = WatchlistMoviesStatus.initial,
    this.message = 'Empty',
    this.watchlistMovies = const <Movie>[],
  });

  final WatchlistMoviesStatus status;
  final List<Movie> watchlistMovies;
  final String message;

  WatchlistMoviesState copyWith({
    WatchlistMoviesStatus Function()? status,
    List<Movie> Function()? watchlistMovies,
    String Function()? message,
  }) {
    return WatchlistMoviesState(
      status: status != null ? status() : this.status,
      watchlistMovies:
          watchlistMovies != null ? watchlistMovies() : this.watchlistMovies,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, watchlistMovies, message];
}
