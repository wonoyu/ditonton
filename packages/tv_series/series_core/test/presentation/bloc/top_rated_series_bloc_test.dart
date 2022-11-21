import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesBloc topRatedSeriesBloc;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  test('initial state should be initial', () {
    expect(topRatedSeriesBloc.state,
        const TopRatedSeriesState(status: SeriesBlocState.initial));
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'emits [Loading, Loaded] when FetchPopularSeries is added.',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedSeries()),
    expect: () => <TopRatedSeriesState>[
      const TopRatedSeriesState(status: SeriesBlocState.loading),
      TopRatedSeriesState(status: SeriesBlocState.loaded, series: tSeriesList)
    ],
    verify: (bloc) => verify(mockGetTopRatedSeries.execute()),
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'emits [Loading, Error] when FetchPopularSeries is added.',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedSeries()),
    expect: () => <TopRatedSeriesState>[
      const TopRatedSeriesState(status: SeriesBlocState.loading),
      const TopRatedSeriesState(
          status: SeriesBlocState.error, message: 'Server Failure')
    ],
  );
}
