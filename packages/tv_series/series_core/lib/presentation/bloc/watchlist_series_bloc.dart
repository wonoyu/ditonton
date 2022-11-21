import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:series_core/presentation/bloc/on_the_air_series_bloc.dart';
import 'package:series_core/series_core.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries _getWatchlistSeries;
  WatchlistSeriesBloc(this._getWatchlistSeries)
      : super(const WatchlistSeriesState()) {
    on<FetchWatchlistSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));

      final result = await _getWatchlistSeries.execute();

      result.fold(
          (failure) => emit(
                state.copyWith(
                    status: () => SeriesBlocState.error,
                    message: () => failure.message),
              ),
          (data) => emit(state.copyWith(
                status: () => SeriesBlocState.loaded,
                series: () => data,
              )));
    });
  }
}
