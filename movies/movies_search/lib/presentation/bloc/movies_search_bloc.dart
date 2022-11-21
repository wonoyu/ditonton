import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_search/movies_search.dart';
import 'package:rxdart/rxdart.dart';

part 'movies_search_event.dart';
part 'movies_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies _searchMovies;
  MoviesSearchBloc(this._searchMovies) : super(const MoviesSearchState()) {
    on<OnQueryChanged>((event, emit) async {
      emit(state.copyWith(status: () => MoviesSearchStatus.loading));
      final query = event.query;
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => MoviesSearchStatus.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => MoviesSearchStatus.loaded,
              searchResult: () => data),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
