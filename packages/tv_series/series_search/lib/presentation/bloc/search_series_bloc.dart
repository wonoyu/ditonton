import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:series_core/series_core.dart';
import 'package:series_search/series_search.dart';

part 'search_series_event.dart';
part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries _searchSeries;
  SearchSeriesBloc(this._searchSeries) : super(const SearchSeriesState()) {
    on<OnQueryChanged>((event, emit) async {
      emit(state.copyWith(status: () => SeriesBlocState.loading));
      final query = event.query;
      final result = await _searchSeries.execute(query);

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => SeriesBlocState.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => SeriesBlocState.loaded, searchResult: () => data),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
