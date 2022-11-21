import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_detail/movies_detail.dart';

import 'movies_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MoviesDetailBloc moviesDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    moviesDetailBloc = MoviesDetailBloc(mockGetMovieDetail);
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

  test('initial state should be initial', () {
    expect(moviesDetailBloc.state,
        const MoviesDetailState(status: MovieDetailStatus.initial));
  });

  blocTest<MoviesDetailBloc, MoviesDetailState>(
      'emits [Loading, Loaded] when FetchMovieDetail is added.',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(1)),
      expect: () => <MoviesDetailState>[
            const MoviesDetailState(status: MovieDetailStatus.loading),
            const MoviesDetailState(
                status: MovieDetailStatus.loaded, movie: testMovieDetail)
          ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(1)));

  blocTest<MoviesDetailBloc, MoviesDetailState>(
      'emits [Loading, Error] when FetchMovieDetail is added.',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(1)),
      expect: () => <MoviesDetailState>[
            const MoviesDetailState(
              status: MovieDetailStatus.loading,
            ),
            const MoviesDetailState(
                status: MovieDetailStatus.error, message: 'Server Failure')
          ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(1)));
}
