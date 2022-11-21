part of 'movie_list_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  const FetchNowPlayingMovies();
}

class FetchPopularMovies extends PopularMoviesEvent {
  const FetchPopularMovies();
}

class FetchTopRatedMovies extends TopRatedMoviesEvent {
  const FetchTopRatedMovies();
}
