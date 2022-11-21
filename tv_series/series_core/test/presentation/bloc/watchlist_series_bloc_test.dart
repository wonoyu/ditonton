import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late WatchlistSeriesBloc watchlistSeriesBloc;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    watchlistSeriesBloc = WatchlistSeriesBloc(mockGetWatchlistSeries);
  });

  test('initial state should be initial', () {
    expect(watchlistSeriesBloc.state,
        const WatchlistSeriesState(status: SeriesBlocState.initial));
  });

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'emits [Loading, Loaded] when FetchWatchlistSeries is added.',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistSeries()),
    expect: () => <WatchlistSeriesState>[
      const WatchlistSeriesState(status: SeriesBlocState.loading),
      WatchlistSeriesState(status: SeriesBlocState.loaded, series: tSeriesList)
    ],
    verify: (bloc) => verify(mockGetWatchlistSeries.execute()),
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'emits [Loading, Error] when FetchWatchlistSeries is added.',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistSeries()),
    expect: () => <WatchlistSeriesState>[
      const WatchlistSeriesState(status: SeriesBlocState.loading),
      const WatchlistSeriesState(
          status: SeriesBlocState.error, message: 'Server Failure')
    ],
  );
}
