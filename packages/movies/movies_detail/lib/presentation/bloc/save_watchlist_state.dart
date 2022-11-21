part of 'save_watchlist_bloc.dart';

class SaveWatchlistState extends Equatable {
  const SaveWatchlistState({
    this.status = MovieDetailStatus.initial,
    this.isAddedToWatchlist = false,
    this.message = 'Empty',
    this.successMessage = '',
    this.errorMessage = '',
  });

  final MovieDetailStatus status;
  final bool isAddedToWatchlist;
  final String message;
  final String successMessage;
  final String errorMessage;

  SaveWatchlistState copyWith({
    MovieDetailStatus Function()? status,
    bool Function()? isAddedToWatchlist,
    String Function()? message,
    String Function()? successMessage,
    String Function()? errorMessage,
  }) {
    return SaveWatchlistState(
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
