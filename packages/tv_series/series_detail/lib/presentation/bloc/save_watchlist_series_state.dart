part of 'save_watchlist_series_bloc.dart';

class SaveWatchlistSeriesState extends Equatable {
  const SaveWatchlistSeriesState({
    this.status = SeriesBlocState.initial,
    this.isAddedToWatchlist = false,
    this.message = 'False',
    this.successMessage = '',
    this.errorMessage = '',
  });

  final SeriesBlocState status;
  final bool isAddedToWatchlist;
  final String message;
  final String successMessage;
  final String errorMessage;

  SaveWatchlistSeriesState copyWith({
    SeriesBlocState Function()? status,
    bool Function()? isAddedToWatchlist,
    String Function()? message,
    String Function()? successMessage,
    String Function()? errorMessage,
  }) {
    return SaveWatchlistSeriesState(
      status: status != null ? status() : this.status,
      isAddedToWatchlist: isAddedToWatchlist != null
          ? isAddedToWatchlist()
          : this.isAddedToWatchlist,
      message: message != null ? message() : this.message,
      successMessage:
          successMessage != null ? successMessage() : this.successMessage,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, isAddedToWatchlist, successMessage, errorMessage];
}
