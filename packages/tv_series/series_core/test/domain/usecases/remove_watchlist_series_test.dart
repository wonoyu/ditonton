import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late RemoveWatchlistSeries usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = RemoveWatchlistSeries(repository);
  });

  test('should remove watchlist series to repository when execute is called',
      () async {
    // arrange
    when(repository.removeWatchlist(tSeriesDetail))
        .thenAnswer((_) async => const Right("Removed from watchlist"));
    // act
    final result = await usecase.execute(tSeriesDetail);
    // assert
    verify(repository.removeWatchlist(tSeriesDetail));
    expect(result, const Right("Removed from watchlist"));
  });
}
