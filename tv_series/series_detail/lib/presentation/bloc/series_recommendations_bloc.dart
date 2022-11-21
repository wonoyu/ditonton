import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series_core/presentation/bloc/on_the_air_series_bloc.dart';
import 'package:series_core/series_core.dart';

part 'series_recommendations_event.dart';
part 'series_recommendations_state.dart';

class SeriesRecommendationsBloc
    extends Bloc<SeriesRecommendationsEvent, SeriesRecommendationsState> {
  final GetSeriesRecommendations _getSeriesRecommendations;
  SeriesRecommendationsBloc(this._getSeriesRecommendations)
      : super(const SeriesRecommendationsState()) {
    on<FetchSeriesRecommendations>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));
      final id = event.id;
      final result = await _getSeriesRecommendations.execute(id);

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
