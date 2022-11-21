import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late GetWatchlistSeries usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = GetWatchlistSeries(repository);
  });

  test('should get watchlist and return list series when execute is called',
      () async {
    // arrange
    when(repository.getWatchlistSeries())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeriesList));
  });
}
