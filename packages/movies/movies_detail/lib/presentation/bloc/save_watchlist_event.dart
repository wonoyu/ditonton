part of 'save_watchlist_bloc.dart';

abstract class SaveWatchlistEvent extends Equatable {
  const SaveWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlist extends SaveWatchlistEvent {
  const AddToWatchlist(this.movie);

  final MovieDetail movie;

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends SaveWatchlistEvent {
  const RemoveFromWatchlist(this.movie);

  final MovieDetail movie;

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends SaveWatchlistEvent {
  const LoadWatchlistStatus(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
