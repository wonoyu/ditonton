import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository repository;
  late GetWatchlistSeriesStatus usecase;

  setUp(() {
    repository = MockSeriesRepository();
    usecase = GetWatchlistSeriesStatus(repository);
  });

  const tId = 1;
  test('should get watchlist series status when executed', () async {
    // arrange
    when(repository.isAddedToWatchlist(tId)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
  });
}
