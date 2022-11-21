import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:series_core/series_core.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tSeriesModel = SeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tSeriesResponse = SeriesResponse(seriesList: [tSeriesModel]);

  group('fromJson', () {
    test('should return valid SeriesModel data class when toJson called', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/series_list.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponse);
    });
  });
}
