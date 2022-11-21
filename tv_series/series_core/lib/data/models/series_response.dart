import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

class SeriesResponse extends Equatable {
  const SeriesResponse({required this.seriesList});

  final List<SeriesModel> seriesList;

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
      seriesList: List<SeriesModel>.from((json['results'] as List)
          .map((x) => SeriesModel.fromJson(x))
          .where((e) => e.posterPath != null)));

  Map<String, dynamic> toJson() =>
      {'results': List.from(seriesList.map((e) => e.toJson()))};

  @override
  List<Object?> get props => [seriesList];
}
