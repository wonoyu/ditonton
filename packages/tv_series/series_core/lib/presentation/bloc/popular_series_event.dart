part of 'popular_series_bloc.dart';

abstract class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularSeries extends PopularSeriesEvent {
  const FetchPopularSeries();

  @override
  List<Object> get props => [];
}
