part of 'watchlist_series_bloc.dart';

class WatchlistSeriesState extends Equatable {
  const WatchlistSeriesState({
    this.status = SeriesBlocState.initial,
    this.series = const <Series>[],
    this.message = 'Empty',
  });

  final SeriesBlocState status;
  final List<Series> series;
  final String message;

  WatchlistSeriesState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? series,
    String Function()? message,
  }) =>
      WatchlistSeriesState(
        status: status != null ? status() : this.status,
        series: series != null ? series() : this.series,
        message: message != null ? message() : this.message,
      );

  @override
  List<Object> get props => [status, series, message];
}
