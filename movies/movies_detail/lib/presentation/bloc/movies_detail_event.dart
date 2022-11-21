part of 'movies_detail_bloc.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MoviesDetailEvent {
  const FetchMovieDetail(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
