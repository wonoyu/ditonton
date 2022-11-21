import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import 'on_the_air_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirSeries])
void main() {
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;
  late OnTheAirSeriesBloc onTheAirSeriesBloc;

  setUp(() {
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    onTheAirSeriesBloc = OnTheAirSeriesBloc(mockGetOnTheAirSeries);
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

  final tSeriesList = <Series>[tSeries];

  test('initial state should be initial', () {
    expect(onTheAirSeriesBloc.state,
        const OnTheAirSeriesState(status: SeriesBlocState.initial));
  });

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'emits [Loading, Loaded] when FetchOnTheAirSeries is added.',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        return onTheAirSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchOnTheAirSeries()),
      expect: () => <OnTheAirSeriesState>[
            const OnTheAirSeriesState(status: SeriesBlocState.loading),
            OnTheAirSeriesState(
                status: SeriesBlocState.loaded, series: tSeriesList)
          ],
      verify: (bloc) => verify(mockGetOnTheAirSeries.execute()));

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'emits [Loading, Error] when FetchOnTheAirSeries is added.',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchOnTheAirSeries()),
      expect: () => <OnTheAirSeriesState>[
            const OnTheAirSeriesState(status: SeriesBlocState.loading),
            const OnTheAirSeriesState(
                status: SeriesBlocState.error, message: 'Server Failure')
          ],
      verify: (bloc) => verify(mockGetOnTheAirSeries.execute()));
}
