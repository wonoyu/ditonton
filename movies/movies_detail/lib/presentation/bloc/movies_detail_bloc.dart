import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_detail/movies_detail.dart';

part 'movies_detail_event.dart';
part 'movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail _getMovieDetail;

  MoviesDetailBloc(this._getMovieDetail) : super(const MoviesDetailState()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(status: () => MovieDetailStatus.loading));
      final id = event.id;
      final result = await _getMovieDetail.execute(id);

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
