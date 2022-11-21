part of 'series_recommendations_bloc.dart';

class SeriesRecommendationsState extends Equatable {
  const SeriesRecommendationsState({
    this.status = SeriesBlocState.initial,
    this.series = const <Series>[],
    this.message = 'Empty',
  });

  final SeriesBlocState status;
  final List<Series> series;
  final String message;

  SeriesRecommendationsState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? series,
    String Function()? message,
  }) =>
      SeriesRecommendationsState(
        status: status != null ? status() : this.status,
        series: series != null ? series() : this.series,
        message: message != null ? message() : this.message,
      );

  @override
  List<Object> get props => [status, series, message];
}
