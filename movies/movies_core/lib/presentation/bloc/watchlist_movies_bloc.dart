import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_core/movies_core.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMoviesBloc(this._getWatchlistMovies)
      : super(
            const WatchlistMoviesState(status: WatchlistMoviesStatus.initial)) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(state.copyWith(status: () => WatchlistMoviesStatus.loading));
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => WatchlistMoviesStatus.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => WatchlistMoviesStatus.loaded,
              watchlistMovies: () => data),
        ),
      );
    });
  }
}
