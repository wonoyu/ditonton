part of 'series_recommendations_bloc.dart';

abstract class SeriesRecommendationsEvent extends Equatable {
  const SeriesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchSeriesRecommendations extends SeriesRecommendationsEvent {
  const FetchSeriesRecommendations(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
