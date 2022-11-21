import 'package:flutter_test/flutter_test.dart';
import 'package:series_core/series_core.dart';

void main() {
  const tNextEpisodeToAirModel = EpisodeToAirModel(
    episodeNumber: 1,
    productionCode: 'productionCode',
    stillPath: 'stillPath',
    airDate: 'airDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
    seasonNumber: 1,
    voteCount: 1,
  );

  const tNextEpisodeToAir = EpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    productionCode: 'productionCode',
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
    seasonNumber: 1,
  );

  test('should be a subclass of Season entity', () async {
    final result = tNextEpisodeToAirModel.toEntity();
    expect(result, tNextEpisodeToAir);
  });
}
