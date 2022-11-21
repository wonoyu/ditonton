part of 'watchlist_series_bloc.dart';

abstract class WatchlistSeriesEvent extends Equatable {
  const WatchlistSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistSeries extends WatchlistSeriesEvent {
  const FetchWatchlistSeries();

  @override
  List<Object> get props => [];
}
