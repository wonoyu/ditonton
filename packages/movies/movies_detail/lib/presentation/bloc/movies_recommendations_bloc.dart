import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_core/movies_core.dart';

import 'movies_detail_bloc.dart';

part 'movies_recommendations_event.dart';
part 'movies_recommendations_state.dart';

class MoviesRecommendationsBloc
    extends Bloc<MoviesRecommendationsEvent, MoviesRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;
  MoviesRecommendationsBloc(this._getMovieRecommendations)
      : super(const MoviesRecommendationsState()) {
    on<FetchMoviesRecommendations>((event, emit) async {
      emit(state.copyWith(status: () => MovieDetailStatus.loading));
      final id = event.id;
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(
          state.copyWith(
              status: () => MovieDetailStatus.error,
              message: () => failure.message),
        ),
        (data) => emit(
          state.copyWith(
              status: () => MovieDetailStatus.loaded, movie: () => data),
        ),
      );
    });
  }
}
