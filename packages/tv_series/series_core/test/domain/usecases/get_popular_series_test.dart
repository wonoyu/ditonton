import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late GetPopularSeries usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = GetPopularSeries(repository);
  });

  final tSeries = <Series>[];
  test('should get popular series when execute is called', () async {
    // arrange
    when(repository.getPopularSeries()).thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
