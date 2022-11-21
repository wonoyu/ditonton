part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {
  const MoviesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends MoviesSearchEvent {
  const OnQueryChanged(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}
