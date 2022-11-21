part of 'top_rated_series_bloc.dart';

abstract class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedSeries extends TopRatedSeriesEvent {
  const FetchTopRatedSeries();

  @override
  List<Object> get props => [];
}
