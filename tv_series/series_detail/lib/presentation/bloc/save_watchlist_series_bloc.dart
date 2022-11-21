import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

part 'save_watchlist_series_event.dart';
part 'save_watchlist_series_state.dart';

class SaveWatchlistSeriesBloc
    extends Bloc<SaveWatchlistSeriesEvent, SaveWatchlistSeriesState> {
  final SaveWatchlistSeries _saveWatchlistSeries;
  final RemoveWatchlistSeries _removeWatchlistSeries;
  final GetWatchlistSeriesStatus _getWatchlistSeriesStatus;
  SaveWatchlistSeriesBloc(this._removeWatchlistSeries,
      this._saveWatchlistSeries, this._getWatchlistSeriesStatus)
      : super(const SaveWatchlistSeriesState()) {
    on<AddToWatchlistSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));
      final series = event.series;
      final result = await _saveWatchlistSeries.execute(series);

      await result.fold((failure) async {
        emit(state.copyWith(
            status: () => SeriesBlocState.error,
            message: () => failure.message,
            errorMessage: () => failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist =
            await _getWatchlistSeriesStatus.execute(series.id);
        emit(state.copyWith(
            status: () => SeriesBlocState.loaded,
            isAddedToWatchlist: () => isAddedToWatchlist,
            message: () => successMessage,
            successMessage: () => successMessage));
      });
    });

    on<RemoveFromWatchlistSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));
      final series = event.series;
      final result = await _removeWatchlistSeries.execute(series);

      await result.fold((failure) async {
        emit(state.copyWith(
            status: () => SeriesBlocState.error,
            message: () => failure.message,
            errorMessage: () => failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist =
            await _getWatchlistSeriesStatus.execute(series.id);
        emit(state.copyWith(
            status: () => SeriesBlocState.loaded,
            isAddedToWatchlist: () => isAddedToWatchlist,
            message: () => successMessage,
            successMessage: () => successMessage));
      });
    });

    on<LoadWatchlistSeriesStatus>((event, emit) async {
      final id = event.id;
      final isAddedToWatchlist = await _getWatchlistSeriesStatus.execute(id);

      emit(state.copyWith(
        status: () => SeriesBlocState.loaded,
        isAddedToWatchlist: () => isAddedToWatchlist,
      ));
    });
  }
}
