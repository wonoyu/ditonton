import 'package:flutter_test/flutter_test.dart';
import 'package:series_core/series_core.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tSeason = Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1);

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
