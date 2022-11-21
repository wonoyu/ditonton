part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent extends Equatable {
  const SearchSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchSeriesEvent {
  const OnQueryChanged(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}
