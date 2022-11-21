import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/domain/usecases/get_watchlist_movies.dart';
import 'package:movies_core/presentation/bloc/watchlist_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
  });

  test('initial state should be initial', () {
    expect(watchlistMoviesBloc.state,
        const WatchlistMoviesState(status: WatchlistMoviesStatus.initial));
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'emits [WatchlistMoviesStatus.loading, WatchlistMoviesStatus.loaded] when FetchWatchlistMovies is added.',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovies()),
      expect: () => <WatchlistMoviesState>[
            const WatchlistMoviesState(status: WatchlistMoviesStatus.loading),
            WatchlistMoviesState(
                status: WatchlistMoviesStatus.loaded,
                watchlistMovies: [testWatchlistMovie])
          ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()));

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'emits [WatchlistMoviesStatus.loading, WatchlistMoviesStatus.error] when MyEvent is added.',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => <WatchlistMoviesState>[
      const WatchlistMoviesState(status: WatchlistMoviesStatus.loading),
      const WatchlistMoviesState(
          status: WatchlistMoviesStatus.error, message: "Can't get data")
    ],
  );
}
