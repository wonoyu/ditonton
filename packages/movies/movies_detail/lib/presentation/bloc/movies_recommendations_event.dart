part of 'movies_recommendations_bloc.dart';

abstract class MoviesRecommendationsEvent extends Equatable {
  const MoviesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesRecommendations extends MoviesRecommendationsEvent {
  const FetchMoviesRecommendations(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
