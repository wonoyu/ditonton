import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_detail/movies_detail.dart';

import 'save_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late SaveWatchlistBloc saveWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    saveWatchlistBloc = SaveWatchlistBloc(
        mockSaveWatchlist, mockGetWatchListStatus, mockRemoveWatchlist);
  });

  const testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Save Watchlist', () {
    test('initial state should be initial', () {
      expect(saveWatchlistBloc.state,
          const SaveWatchlistState(status: MovieDetailStatus.initial));
    });

    blocTest<SaveWatchlistBloc, SaveWatchlistState>(
        'emits [Loading, Loaded] when AddToWatchlist is added.',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlist(testMovieDetail)),
        expect: () => <SaveWatchlistState>[
              const SaveWatchlistState(status: MovieDetailStatus.loading),
              const SaveWatchlistState(
                  status: MovieDetailStatus.loaded,
                  isAddedToWatchlist: true,
                  successMessage: 'Success',
                  message: 'Success')
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        });

    blocTest<SaveWatchlistBloc, SaveWatchlistState>(
        'emits [Loading, Error] when AddToWatchlist is added.',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Error')));
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlist(testMovieDetail)),
        expect: () => <SaveWatchlistState>[
              const SaveWatchlistState(status: MovieDetailStatus.loading),
              const SaveWatchlistState(
                  status: MovieDetailStatus.error,
                  isAddedToWatchlist: false,
                  errorMessage: 'Error',
                  message: 'Error')
            ],
        verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)));
  });

  group('Remove Watchlist', () {
    test('initial state should be initial', () {
      expect(saveWatchlistBloc.state,
          const SaveWatchlistState(status: MovieDetailStatus.initial));
    });

    blocTest<SaveWatchlistBloc, SaveWatchlistState>(
        'emits [Loading, Loaded] when RemoveFromWatchlist is added.',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        expect: () => <SaveWatchlistState>[
              const SaveWatchlistState(status: MovieDetailStatus.loading),
              const SaveWatchlistState(
                  status: MovieDetailStatus.loaded,
                  successMessage: 'Success',
                  message: 'Success')
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        });

    blocTest<SaveWatchlistBloc, SaveWatchlistState>(
        'emits [Loading, Error] when RemoveFromWatchlist is added.',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Error')));
          return saveWatchlistBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        expect: () => <SaveWatchlistState>[
              const SaveWatchlistState(status: MovieDetailStatus.loading),
              const SaveWatchlistState(
                  status: MovieDetailStatus.error,
                  errorMessage: 'Error',
                  message: 'Error')
            ],
        verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)));
  });

  blocTest<SaveWatchlistBloc, SaveWatchlistState>(
      'emits [Loaded] when LoadWatchlistStatus is added.',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return saveWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(testMovieDetail.id)),
      expect: () => <SaveWatchlistState>[
            const SaveWatchlistState(
                status: MovieDetailStatus.loaded, isAddedToWatchlist: false)
          ],
      verify: (bloc) =>
          verify(mockGetWatchListStatus.execute(testMovieDetail.id)));
}
