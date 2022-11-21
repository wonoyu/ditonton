import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository repository;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(repository);
  });

  test('should save series to the repository', () async {
    // arrange
    when(repository.saveWatchlist(tSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tSeriesDetail);
    // assert
    verify(repository.saveWatchlist(tSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
