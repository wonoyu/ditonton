import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/domain/entities/series.dart';
import 'package:series_core/presentation/bloc/on_the_air_series_bloc.dart';
import 'package:series_core/series_core.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries _getPopularSeries;
  PopularSeriesBloc(this._getPopularSeries)
      : super(const PopularSeriesState()) {
    on<FetchPopularSeries>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));

      final result = await _getPopularSeries.execute();

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
