part of 'series_detail_bloc.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchSeriesDetail extends SeriesDetailEvent {
  const FetchSeriesDetail(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
