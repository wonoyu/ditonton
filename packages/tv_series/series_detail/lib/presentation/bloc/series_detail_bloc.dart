import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/series_detail.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail _getSeriesDetail;
  SeriesDetailBloc(this._getSeriesDetail) : super(const SeriesDetailState()) {
    on<FetchSeriesDetail>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));
      final id = event.id;
      final result = await _getSeriesDetail.execute(id);

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
