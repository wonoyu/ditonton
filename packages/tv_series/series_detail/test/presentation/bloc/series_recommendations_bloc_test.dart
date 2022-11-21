import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/series_detail.dart';

import 'series_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendations])
void main() {
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late SeriesRecommendationsBloc moviesRecommendationsBloc;

  setUp(() {
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    moviesRecommendationsBloc =
        SeriesRecommendationsBloc(mockGetSeriesRecommendations);
  });

  final tSeries = Series(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeriesList = [tSeries];

  test('inital state should be initial', () {
    expect(moviesRecommendationsBloc.state,
        const SeriesRecommendationsState(status: SeriesBlocState.initial));
  });

  blocTest<SeriesRecommendationsBloc, SeriesRecommendationsState>(
      'emits [MyState] when MyEvent is added.',
      build: () {
        when(mockGetSeriesRecommendations.execute(1))
            .thenAnswer((_) async => Right(tSeriesList));
        return moviesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesRecommendations(1)),
      expect: () => <SeriesRecommendationsState>[
            const SeriesRecommendationsState(status: SeriesBlocState.loading),
            SeriesRecommendationsState(
                status: SeriesBlocState.loaded, series: tSeriesList)
          ],
      verify: (bloc) => verify(mockGetSeriesRecommendations.execute(1)));

  blocTest<SeriesRecommendationsBloc, SeriesRecommendationsState>(
      'emits [Loading, Error] when FetchMoviesRecommendations is added.',
      build: () {
        when(mockGetSeriesRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviesRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesRecommendations(1)),
      expect: () => <SeriesRecommendationsState>[
            const SeriesRecommendationsState(status: SeriesBlocState.loading),
            const SeriesRecommendationsState(
                status: SeriesBlocState.error, message: 'Server Failure')
          ],
      verify: (bloc) => verify(mockGetSeriesRecommendations.execute(1)));
}
