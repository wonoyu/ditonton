import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';
import 'package:series_search/domain/usecases/search_series.dart';

import '../../../../series_core/test/helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late SearchSeries usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = SearchSeries(repository);
  });

  const tQuery = "Game of Thrones";
  final tSeriesList = <Series>[];

  test('should return list series when execute is called', () async {
    // arrange
    when(repository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeriesList));
  });
}
