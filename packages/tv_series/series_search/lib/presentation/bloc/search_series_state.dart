part of 'search_series_bloc.dart';

class SearchSeriesState extends Equatable {
  const SearchSeriesState({
    this.status = SeriesBlocState.initial,
    this.searchResult = const <Series>[],
    this.message = 'Empty',
  });

  final SeriesBlocState status;
  final List<Series> searchResult;
  final String message;

  SearchSeriesState copyWith({
    SeriesBlocState Function()? status,
    List<Series> Function()? searchResult,
    String Function()? message,
  }) =>
      SearchSeriesState(
        status: status != null ? status() : this.status,
        searchResult: searchResult != null ? searchResult() : this.searchResult,
        message: message != null ? message() : this.message,
      );

  @override
  List<Object> get props => [status, searchResult, message];
}
