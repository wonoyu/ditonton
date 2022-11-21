import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_search/movies_search.dart';

import 'movies_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = MoviesSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state,
        const MoviesSearchState(status: MoviesSearchStatus.initial));
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  blocTest<MoviesSearchBloc, MoviesSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const MoviesSearchState(status: MoviesSearchStatus.loading),
      MoviesSearchState(
          status: MoviesSearchStatus.loaded, searchResult: tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MoviesSearchBloc, MoviesSearchState>(
      'Should emit [Loading, Error] when get seach is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            const MoviesSearchState(status: MoviesSearchStatus.loading),
            const MoviesSearchState(
                status: MoviesSearchStatus.error, message: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });
}
