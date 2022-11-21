part of 'on_the_air_series_bloc.dart';

enum SeriesBlocState { initial, loading, loaded, error }

class OnTheAirSeriesState extends Equatable {
  const OnTheAirSeriesState(
      {this.status = SeriesBlocState.initial,
      this.series = const <Series>[],
      this.message = 'Empty'});

  final SeriesBlocState status;
  final List<Series> series;
  final String message;

  OnTheAirSeriesState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? series,
    String Function()? message,
  }) {
    return OnTheAirSeriesState(
      status: status != null ? status() : this.status,
      series: series != null ? series() : this.series,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status, series, message];
}
