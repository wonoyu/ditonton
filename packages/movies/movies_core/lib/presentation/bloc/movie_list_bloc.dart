import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_core/movies_core.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(const NowPlayingMoviesState()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(status: () => MovieListStatus.loading));
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => MovieListStatus.error,
              message: () => failure.message),
        ),
        (data) => emit(
          NowPlayingMoviesState(status: MovieListStatus.loaded, movies: data),
        ),
      );
    });
  }
}

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies)
      : super(const PopularMoviesState()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(state.copyWith(status: () => MovieListStatus.loading));
      final result = await _getPopularMovies.execute();

      result.fold(
          (failure) => emit(state.copyWith(
              status: () => MovieListStatus.error,
              message: () => failure.message)),
          (data) => emit(state.copyWith(
              status: () => MovieListStatus.loaded, movies: () => data)));
    });
  }
}

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMoviesBloc(this._getTopRatedMovies)
      : super(const TopRatedMoviesState()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(status: () => MovieListStatus.loading));
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => MovieListStatus.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => MovieListStatus.loaded, movies: () => data),
        ),
      );
    });
  }
}
