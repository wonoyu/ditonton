import 'package:flutter_test/flutter_test.dart';
import 'package:series_core/series_core.dart';

void main() {
  const tSeriesModel = SeriesModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeries = Series(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeriesJson = <String, dynamic>{
    'backdrop_path': 'backdropPath',
    'genre_ids': [1, 2, 3],
    'id': 1,
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1,
    'poster_path': 'posterPath',
    'first_air_date': 'firstAirDate',
    'name': 'name',
    'vote_average': 1,
    'vote_count': 1,
  };

  group('toEntity', () {
    test('should return Series entity when toEntity called', () {
      final tResult = tSeriesModel.toEntity();
      expect(tResult, tSeries);
    });
  });

  group('toJson', () {
    test('should return Map<String, dynamic> when toJson called', () {
      final tResult = tSeriesModel.toJson();
      expect(tResult, tSeriesJson);
    });
  });
}
