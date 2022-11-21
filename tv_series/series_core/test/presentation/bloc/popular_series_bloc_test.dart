import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc popularSeriesBloc;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  test('initial state should be initial', () {
    expect(popularSeriesBloc.state,
        const PopularSeriesState(status: SeriesBlocState.initial));
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'emits [Loading, Loaded] when FetchPopularSeries is added.',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularSeries()),
    expect: () => <PopularSeriesState>[
      const PopularSeriesState(status: SeriesBlocState.loading),
      PopularSeriesState(status: SeriesBlocState.loaded, series: tSeriesList)
    ],
    verify: (bloc) => verify(mockGetPopularSeries.execute()),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'emits [Loading, Error] when FetchPopularSeries is added.',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularSeries()),
    expect: () => <PopularSeriesState>[
      const PopularSeriesState(status: SeriesBlocState.loading),
      const PopularSeriesState(
          status: SeriesBlocState.error, message: 'Server Failure')
    ],
  );
}
