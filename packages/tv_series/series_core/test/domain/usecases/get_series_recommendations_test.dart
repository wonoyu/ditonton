import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late GetSeriesRecommendations usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = GetSeriesRecommendations(repository);
  });

  const tId = 1;
  final tSeries = <Series>[];
  test('should get series recommendations from repository when executed',
      () async {
    // arrange
    when(repository.getSeriesRecommendations(tId))
        .thenAnswer((realInvocation) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
