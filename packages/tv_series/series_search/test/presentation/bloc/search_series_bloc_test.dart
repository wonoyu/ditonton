import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';
import 'package:series_search/series_search.dart';

import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc searchBloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchBloc = SearchSeriesBloc(mockSearchSeries);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state,
        const SearchSeriesState(status: SeriesBlocState.initial));
  });

  final tSeriesModel = Series(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: const [18, 9648],
    id: 31917,
    originalName: 'Pretty Little Liars',
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    firstAirDate: '2010-06-08',
    name: 'Pretty Little Liars',
    voteAverage: 5.04,
    voteCount: 133,
  );
  final tSeriesList = <Series>[tSeriesModel];
  const tQuery = 'pretty little liars';

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const SearchSeriesState(status: SeriesBlocState.loading),
      SearchSeriesState(
          status: SeriesBlocState.loaded, searchResult: tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
      'Should emit [Loading, Error] when get seach is unsuccessful',
      build: () {
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            const SearchSeriesState(status: SeriesBlocState.loading),
            const SearchSeriesState(
                status: SeriesBlocState.error, message: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      });
}
