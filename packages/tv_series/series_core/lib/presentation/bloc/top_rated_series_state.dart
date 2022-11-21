part of 'top_rated_series_bloc.dart';

class TopRatedSeriesState extends Equatable {
  const TopRatedSeriesState(
      {this.status = SeriesBlocState.initial,
      this.series = const <Series>[],
      this.message = 'Empty'});

  final SeriesBlocState status;
  final List<Series> series;
  final String message;

  TopRatedSeriesState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? series,
    String Function()? message,
  }) =>
      TopRatedSeriesState(
        status: status != null ? status() : this.status,
        series: series != null ? series() : this.series,
        message: message != null ? message() : this.message,
      );

  @override
  List<Object> get props => [status, series, message];
}
