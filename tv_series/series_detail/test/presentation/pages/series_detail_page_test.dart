import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series_core/series_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_detail/series_detail.dart';

class MockSeriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class MockSeriesRecommendationsBloc
    extends MockBloc<SeriesRecommendationsEvent, SeriesRecommendationsState>
    implements SeriesRecommendationsBloc {}

class MockSaveWatchlistSeriesBloc
    extends MockBloc<SaveWatchlistSeriesEvent, SaveWatchlistSeriesState>
    implements SaveWatchlistSeriesBloc {}

void main() {
  late SeriesDetailBloc mockSeriesDetailBloc;
  late SeriesRecommendationsBloc mockSeriesRecommendationsBloc;
  late SaveWatchlistSeriesBloc mockSaveWatchlistSeriesBloc;

  setUp(() {
    mockSeriesDetailBloc = MockSeriesDetailBloc();
    mockSeriesRecommendationsBloc = MockSeriesRecommendationsBloc();
    mockSaveWatchlistSeriesBloc = MockSaveWatchlistSeriesBloc();
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

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => mockSeriesDetailBloc),
        BlocProvider(create: (c) => mockSeriesRecommendationsBloc),
        BlocProvider(create: (c) => mockSaveWatchlistSeriesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Series Detail Page', () {
    testWidgets(
        'Watchlist button should display add icon when series not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockSeriesDetailBloc.state).thenReturn(const SeriesDetailState(
          status: SeriesBlocState.loaded, series: tSeriesDetail));
      when(() => mockSeriesRecommendationsBloc.state).thenReturn(
          SeriesRecommendationsState(
              status: SeriesBlocState.loaded, series: tSeriesList));
      when(() => mockSaveWatchlistSeriesBloc.state).thenReturn(
          const SaveWatchlistSeriesState(
              status: SeriesBlocState.loaded,
              isAddedToWatchlist: false,
              successMessage: 'Success',
              message: 'Success'));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when series is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockSeriesDetailBloc.state).thenReturn(const SeriesDetailState(
          status: SeriesBlocState.loaded, series: tSeriesDetail));
      when(() => mockSeriesRecommendationsBloc.state).thenReturn(
          SeriesRecommendationsState(
              status: SeriesBlocState.loaded, series: tSeriesList));
      when(() => mockSaveWatchlistSeriesBloc.state).thenReturn(
          const SaveWatchlistSeriesState(
              status: SeriesBlocState.loaded,
              isAddedToWatchlist: true,
              successMessage: 'Success',
              message: 'Success'));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockSeriesDetailBloc.state).thenReturn(const SeriesDetailState(
          status: SeriesBlocState.loaded, series: tSeriesDetail));
      when(() => mockSeriesRecommendationsBloc.state).thenReturn(
          SeriesRecommendationsState(
              status: SeriesBlocState.loaded, series: tSeriesList));

      when(() => mockSaveWatchlistSeriesBloc.state).thenReturn(
          const SaveWatchlistSeriesState(
              status: SeriesBlocState.loaded,
              isAddedToWatchlist: false,
              successMessage: 'Added to Watchlist',
              message: 'Added to Watchlist'));
      whenListen(
          mockSaveWatchlistSeriesBloc,
          Stream.fromIterable([
            const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
            const SaveWatchlistSeriesState(
                status: SeriesBlocState.loaded,
                isAddedToWatchlist: false,
                successMessage: 'Added to Watchlist',
                message: 'Added to Watchlist')
          ]));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      // expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockSeriesDetailBloc.state).thenReturn(const SeriesDetailState(
          status: SeriesBlocState.loaded, series: tSeriesDetail));
      when(() => mockSeriesRecommendationsBloc.state).thenReturn(
          SeriesRecommendationsState(
              status: SeriesBlocState.loaded, series: tSeriesList));
      when(() => mockSaveWatchlistSeriesBloc.state).thenReturn(
          const SaveWatchlistSeriesState(
              status: SeriesBlocState.error,
              isAddedToWatchlist: false,
              errorMessage: 'Failed',
              message: 'Failed'));
      whenListen(
          mockSaveWatchlistSeriesBloc,
          Stream.fromIterable([
            const SaveWatchlistSeriesState(status: SeriesBlocState.loading),
            const SaveWatchlistSeriesState(
                status: SeriesBlocState.error,
                isAddedToWatchlist: false,
                errorMessage: 'Failed',
                message: 'Failed')
          ]));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });
}
