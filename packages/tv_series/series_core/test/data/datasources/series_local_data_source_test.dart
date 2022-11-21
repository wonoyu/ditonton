import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper databaseHelper;

  setUp(() {
    databaseHelper = MockDatabaseHelper();
    dataSource = SeriesLocalDataSourceImpl(databaseHelper: databaseHelper);
  });

  group('save series to watchlist', () {
    test('should return success message when data is inserted to the database',
        () async {
      // arrange
      when(databaseHelper.insertSeriesWatchlist(tSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test(
        'should throw DatabaseException when failed to insert data to database',
        () {
      // arrange
      when(databaseHelper.insertSeriesWatchlist(tSeriesTable))
          .thenThrow(Exception());
      // act
      final result = dataSource.insertWatchlist(tSeriesTable);
      // assert
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove series from watchlist', () {
    test(
        'should return success message when series is successfully removed from database',
        () async {
      // arrange
      when(databaseHelper.removeSeriesWatchlist(tSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when failed to remove data from watchlist database',
        () {
      // arrange
      when(databaseHelper.removeSeriesWatchlist(tSeriesTable))
          .thenThrow(Exception());
      // act
      final result = dataSource.removeWatchlist(tSeriesTable);
      // assert
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tv series by id', () {
    int tId = 1;
    test('should return SeriesDetail when data is found', () async {
      // arrange
      when(databaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => tSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, tSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(databaseHelper.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(databaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [tSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [tSeriesTable]);
    });
  });
}
