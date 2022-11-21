part of 'save_watchlist_series_bloc.dart';

abstract class SaveWatchlistSeriesEvent extends Equatable {
  const SaveWatchlistSeriesEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlistSeries extends SaveWatchlistSeriesEvent {
  const AddToWatchlistSeries(this.series);

  final SeriesDetail series;

  @override
  List<Object> get props => [series];
}

class RemoveFromWatchlistSeries extends SaveWatchlistSeriesEvent {
  const RemoveFromWatchlistSeries(this.series);

  final SeriesDetail series;

  @override
  List<Object> get props => [series];
}

class LoadWatchlistSeriesStatus extends SaveWatchlistSeriesEvent {
  const LoadWatchlistSeriesStatus(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
