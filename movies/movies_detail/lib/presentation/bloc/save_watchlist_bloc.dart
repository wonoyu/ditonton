import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_core/movies_core.dart';

import 'movies_detail_bloc.dart';

part 'save_watchlist_event.dart';
part 'save_watchlist_state.dart';

class SaveWatchlistBloc extends Bloc<SaveWatchlistEvent, SaveWatchlistState> {
  final SaveWatchlist _saveWatchlist;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  SaveWatchlistBloc(
      this._saveWatchlist, this._getWatchListStatus, this._removeWatchlist)
      : super(const SaveWatchlistState()) {
    on<AddToWatchlist>((event, emit) async {
      emit(state.copyWith(status: () => MovieDetailStatus.loading));
      final movie = event.movie;
      final result = await _saveWatchlist.execute(movie);

      await result.fold((failure) async {
        emit(state.copyWith(
            status: () => MovieDetailStatus.error,
            message: () => failure.message,
            errorMessage: () => failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListStatus.execute(movie.id);
        emit(state.copyWith(
            status: () => MovieDetailStatus.loaded,
            isAddedToWatchlist: () => isAddedToWatchlist,
            message: () => successMessage,
            successMessage: () => successMessage));
      });
    });

    on<RemoveFromWatchlist>((event, emit) async {
      emit(state.copyWith(status: () => MovieDetailStatus.loading));
      final movie = event.movie;
      final result = await _removeWatchlist.execute(movie);

      await result.fold((failure) async {
        emit(state.copyWith(
            status: () => MovieDetailStatus.error,
            message: () => failure.message,
            errorMessage: () => failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListStatus.execute(movie.id);
        emit(state.copyWith(
            status: () => MovieDetailStatus.loaded,
            isAddedToWatchlist: () => isAddedToWatchlist,
            message: () => successMessage,
            successMessage: () => successMessage));
      });
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final isAddedToWatchlist = await _getWatchListStatus.execute(id);

      emit(state.copyWith(
        status: () => MovieDetailStatus.loaded,
        isAddedToWatchlist: () => isAddedToWatchlist,
      ));
    });
  }
}
