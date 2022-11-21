import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/movies_core.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies Bloc', () {
    test('initial state should be initial', () {
      expect(nowPlayingMoviesBloc.state,
          const NowPlayingMoviesState(status: MovieListStatus.initial));
    });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'emits [MovieListStatus.loading, MovieListStatus.loaded] when FetchNowPlayingMovies is added.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
      expect: () => <NowPlayingMoviesState>[
        const NowPlayingMoviesState(status: MovieListStatus.loading),
        NowPlayingMoviesState(
            status: MovieListStatus.loaded, movies: tMovieList)
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        'emits [MovieListStatus.loading, MovieListStatus.error] when FetchNowPlayingMovies is added.',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return nowPlayingMoviesBloc;
        },
        act: (bloc) => bloc.add(const FetchNowPlayingMovies()),
        expect: () => <NowPlayingMoviesState>[
              const NowPlayingMoviesState(status: MovieListStatus.loading),
              const NowPlayingMoviesState(
                  status: MovieListStatus.error, message: "Server Failure")
            ],
        verify: (bloc) => verify(mockGetNowPlayingMovies.execute()));
  });

  group('Popular Movies Bloc', () {
    test('initial state should be initial', () {
      expect(popularMoviesBloc.state,
          const PopularMoviesState(status: MovieListStatus.initial));
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'emits [MovieListStatus.loading, MovieListStatus.loaded] when FetchPopularMovies is added.',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(const FetchPopularMovies()),
        expect: () => <PopularMoviesState>[
              const PopularMoviesState(status: MovieListStatus.loading),
              PopularMoviesState(
                  status: MovieListStatus.loaded, movies: tMovieList),
            ],
        verify: (bloc) => verify(mockGetPopularMovies.execute()));

    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'emits [MovieListStatus.loading, MovieListStatus.error] when MyEvent is added.',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(const FetchPopularMovies()),
        expect: () => <PopularMoviesState>[
              const PopularMoviesState(status: MovieListStatus.loading),
              const PopularMoviesState(
                  status: MovieListStatus.error, message: 'Server Failure'),
            ],
        verify: (bloc) => verify(mockGetPopularMovies.execute()));
  });

  group('Top Rated Movies Bloc', () {
    test('initial state should be initial', () {
      expect(topRatedMoviesBloc.state,
          const TopRatedMoviesState(status: MovieListStatus.initial));
    });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'emits [MovieListStatus.loading, MovieListStatus.loaded] when MyEvent is added.',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(const FetchTopRatedMovies()),
        expect: () => <TopRatedMoviesState>[
              const TopRatedMoviesState(status: MovieListStatus.loading),
              TopRatedMoviesState(
                  status: MovieListStatus.loaded, movies: tMovieList),
            ],
        verify: (bloc) => verify(mockGetTopRatedMovies.execute()));

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'emits [MovieListStatus.loading, MovieListStatus.error] when FetchTopRatedMovies is added.',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(const FetchTopRatedMovies()),
        expect: () => <TopRatedMoviesState>[
              const TopRatedMoviesState(status: MovieListStatus.loading),
              const TopRatedMoviesState(
                  status: MovieListStatus.error, message: 'Server Failure'),
            ],
        verify: (bloc) => verify(mockGetTopRatedMovies.execute()));
  });
}
