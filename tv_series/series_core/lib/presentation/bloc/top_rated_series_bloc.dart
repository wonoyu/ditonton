import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;
  TopRatedSeriesBloc(this._getTopRatedSeries)
      : super(const TopRatedSeriesState()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));

      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => SeriesBlocState.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => SeriesBlocState.loaded, series: () => data),
        ),
      );
    });
  }
}
