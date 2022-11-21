import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/series_detail.dart';

import 'save_watchlist_series_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistSeriesStatus, SaveWatchlistSeries, RemoveWatchlistSeries])
void main() {
  late SaveWatchlistSeriesBloc saveWatchlistBloc;
  late MockGetWatchlistSeriesStatus mockGetWatchListStatus;
  late MockSaveWatchlistSeries mockSaveWatchlist;
  late MockRemoveWatchlistSeries mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchlistSeriesStatus();
    mockSaveWatchlist = MockSaveWatchlistSeries();
    mockRemoveWatchlist = MockRemoveWatchlistSeries();
    saveWatchlistBloc = SaveWatchlistSeriesBloc(
        mockRemoveWatchlist, mockSaveWatchlist, mockGetWatchListStatus);
  });

  const tSeriesDetail = SeriesDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: "originalName",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    lastAirDate: "lastAirDate",
    lastEpisodeToAir: EpisodeToAir(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    ),
    nextEpisodeToAir: EpisodeToAir(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    ),
    name: "name",
    voteAverage: 1,
    voteCount: 1,
    seasons: [
      Season(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1),
    ],
  );

  group('Save Watchlist', () {
    test('initial state should be initial', () {
      expect(saveWatchlistBloc.state,
          const SaveWatchlistSeriesState(status: SeriesBlocState.initial));
    });

    blocTest<SaveWatchlistSeriesBloc, SaveWatchlistSeriesState>(
        'emits [Loading, Loaded] when AddToWatchlist is added.',
        build: () {
          when(mockSaveWatchlist.execute(tSeriesDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(tSeriesDetail.id))
              .thenAnswer((_) async => true);
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlistSeries(tSeriesDetail)),
        expect: () => <SaveWatchlistSeriesState>[
              const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
              const SaveWatchlistSeriesState(
                  status: SeriesBlocState.loaded,
                  isAddedToWatchlist: true,
                  successMessage: 'Success',
                  message: 'Success')
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tSeriesDetail));
          verify(mockGetWatchListStatus.execute(tSeriesDetail.id));
        });

    blocTest<SaveWatchlistSeriesBloc, SaveWatchlistSeriesState>(
        'emits [Loading, Error] when AddToWatchlist is added.',
        build: () {
          when(mockSaveWatchlist.execute(tSeriesDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Error')));
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlistSeries(tSeriesDetail)),
        expect: () => <SaveWatchlistSeriesState>[
              const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
              const SaveWatchlistSeriesState(
                  status: SeriesBlocState.error,
                  isAddedToWatchlist: false,
                  errorMessage: 'Error',
                  message: 'Error')
            ],
        verify: (bloc) => verify(mockSaveWatchlist.execute(tSeriesDetail)));
  });

  group('Remove Watchlist', () {
    test('initial state should be initial', () {
      expect(saveWatchlistBloc.state,
          const SaveWatchlistSeriesState(status: SeriesBlocState.initial));
    });

    blocTest<SaveWatchlistSeriesBloc, SaveWatchlistSeriesState>(
        'emits [Loading, Loaded] when RemoveFromWatchlist is added.',
        build: () {
          when(mockRemoveWatchlist.execute(tSeriesDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(tSeriesDetail.id))
              .thenAnswer((_) async => false);
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlistSeries(tSeriesDetail)),
        expect: () => <SaveWatchlistSeriesState>[
              const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
              const SaveWatchlistSeriesState(
                  status: SeriesBlocState.loaded,
                  successMessage: 'Success',
                  message: 'Success')
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tSeriesDetail));
          verify(mockGetWatchListStatus.execute(tSeriesDetail.id));
        });

    blocTest<SaveWatchlistSeriesBloc, SaveWatchlistSeriesState>(
        'emits [Loading, Error] when RemoveFromWatchlist is added.',
        build: () {
          when(mockRemoveWatchlist.execute(tSeriesDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Error')));
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlistSeries(tSeriesDetail)),
        expect: () => <SaveWatchlistSeriesState>[
              const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
              const SaveWatchlistSeriesState(
                  status: SeriesBlocState.error,
                  errorMessage: 'Error',
                  message: 'Error')
            ],
        verify: (bloc) => verify(mockRemoveWatchlist.execute(tSeriesDetail)));
  });

  blocTest<SaveWatchlistSeriesBloc, SaveWatchlistSeriesState>(
      'emits [Loaded] when LoadWatchlistStatus is added.',
      build: () {
        when(mockGetWatchListStatus.execute(tSeriesDetail.id))
            .thenAnswer((_) async => false);
        return saveWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistSeriesStatus(tSeriesDetail.id)),
      expect: () => <SaveWatchlistSeriesState>[
            const SaveWatchlistSeriesState(
                status: SeriesBlocState.loaded, isAddedToWatchlist: false)
          ],
      verify: (bloc) =>
          verify(mockGetWatchListStatus.execute(tSeriesDetail.id)));
}
