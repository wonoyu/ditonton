part of 'series_detail_bloc.dart';

class SeriesDetailState extends Equatable {
  const SeriesDetailState(
      {this.status = SeriesBlocState.initial,
      this.series,
      this.message = 'Empty'});

  final SeriesBlocState status;
  final SeriesDetail? series;
  final String message;

  SeriesDetailState copyWith({
    SeriesBlocState Function()? status,
    SeriesDetail Function()? series,
    String Function()? message,
  }) =>
      SeriesDetailState(
        status: status != null ? status() : this.status,
        series: series != null ? series() : this.series,
        message: message != null ? message() : this.message,
      );

  @override
  List<Object?> get props => [status, series, message];
}
