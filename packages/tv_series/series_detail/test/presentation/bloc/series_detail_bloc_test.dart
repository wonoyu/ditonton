import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/series_detail.dart';

import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late SeriesDetailBloc moviesDetailBloc;
  late MockGetSeriesDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetSeriesDetail();
    moviesDetailBloc = SeriesDetailBloc(mockGetMovieDetail);
  });

  const tSeriesDetail = SeriesDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: "originalName",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    lastAirDate: "lastAirDate",
    lastEpisodeToAir: EpisodeToAir(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    ),
    nextEpisodeToAir: EpisodeToAir(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    ),
    name: "name",
    voteAverage: 1,
    voteCount: 1,
    seasons: [
      Season(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1),
    ],
  );

  test('initial state should be initial', () {
    expect(moviesDetailBloc.state,
        const SeriesDetailState(status: SeriesBlocState.initial));
  });

  blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [Loading, Loaded] when FetchSeriesDetail is added.',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => const Right(tSeriesDetail));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetail(1)),
      expect: () => <SeriesDetailState>[
            const SeriesDetailState(status: SeriesBlocState.loading),
            const SeriesDetailState(
                status: SeriesBlocState.loaded, series: tSeriesDetail)
          ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(1)));

  blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [Loading, Error] when FetchSeriesDetail is added.',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetail(1)),
      expect: () => <SeriesDetailState>[
            const SeriesDetailState(
              status: SeriesBlocState.loading,
            ),
            const SeriesDetailState(
                status: SeriesBlocState.error, message: 'Server Failure')
          ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(1)));
}
