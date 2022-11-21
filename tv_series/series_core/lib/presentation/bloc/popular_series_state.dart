part of 'popular_series_bloc.dart';

class PopularSeriesState extends Equatable {
  const PopularSeriesState({
    this.status = SeriesBlocState.initial,
    this.series = const <Series>[],
    this.message = 'Empty',
  });

  final SeriesBlocState status;
  final List<Series> series;
  final String message;

  PopularSeriesState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? series,
    String Function()? message,
  }) {
    return PopularSeriesState(
      status: status != null ? status() : this.status,
      series: series != null ? series() : this.series,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, series, message];
}
