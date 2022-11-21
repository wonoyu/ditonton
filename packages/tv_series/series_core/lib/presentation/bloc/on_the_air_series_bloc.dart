import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/series_core.dart';

part 'on_the_air_series_event.dart';
part 'on_the_air_series_state.dart';

class OnTheAirSeriesBloc
    extends Bloc<OnTheAirSeriesEvent, OnTheAirSeriesState> {
  final GetOnTheAirSeries _getOnTheAirSeries;
  OnTheAirSeriesBloc(this._getOnTheAirSeries)
      : super(const OnTheAirSeriesState()) {
    on<FetchOnTheAirSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));

      final result = await _getOnTheAirSeries.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: () => SeriesBlocState.error,
            message: () => failure.message,
          ),
        ),
        (data) => emit(
          state.copyWith(
              status: () => SeriesBlocState.loaded, series: () => data),
        ),
      );
    });
  }
}
