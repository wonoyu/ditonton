import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_detail/movies_detail.dart';

import 'movies_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MoviesRecommendationsBloc moviesRecommendationsBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    moviesRecommendationsBloc =
        MoviesRecommendationsBloc(mockGetMovieRecommendations);
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
  final tMovies = <Movie>[tMovie];

  test('inital state should be initial', () {
    expect(moviesRecommendationsBloc.state,
        const MoviesRecommendationsState(status: MovieDetailStatus.initial));
  });

  blocTest<MoviesRecommendationsBloc, MoviesRecommendationsState>(
      'emits [MyState] when MyEvent is added.',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(tMovies));
        return moviesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchMoviesRecommendations(1)),
      expect: () => <MoviesRecommendationsState>[
            const MoviesRecommendationsState(status: MovieDetailStatus.loading),
            MoviesRecommendationsState(
                status: MovieDetailStatus.loaded, movie: tMovies)
          ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(1)));

  blocTest<MoviesRecommendationsBloc, MoviesRecommendationsState>(
      'emits [Loading, Error] when FetchMoviesRecommendations is added.',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchMoviesRecommendations(1)),
      expect: () => <MoviesRecommendationsState>[
            const MoviesRecommendationsState(status: MovieDetailStatus.loading),
            const MoviesRecommendationsState(
                status: MovieDetailStatus.error, message: 'Server Failure')
          ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(1)));
}
