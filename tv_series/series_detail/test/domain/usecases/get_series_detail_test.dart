import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_detail/domain/usecases/get_series_detail.dart';

import '../../../../series_core/test/dummy_data/dummy_objects.dart';
import '../../../../series_core/test/helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository mockSeriesRepository;
  late GetSeriesDetail usecase;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockSeriesRepository);
  });

  const tId = 1;
  test('should get series detail when execute is called', () async {
    // arrange
    when(mockSeriesRepository.getSeriesDetail(tId))
        .thenAnswer((_) async => const Right(tSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(tSeriesDetail));
  });
}
