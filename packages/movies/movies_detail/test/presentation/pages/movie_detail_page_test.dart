import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_detail/movies_detail.dart';

class MockMoviesDetailBloc
    extends MockBloc<MoviesDetailEvent, MoviesDetailState>
    implements MoviesDetailBloc {}

class MockMoviesRecommendationsBloc
    extends MockBloc<MoviesRecommendationsEvent, MoviesRecommendationsState>
    implements MoviesRecommendationsBloc {}

class MockSaveWatchlistBloc
    extends MockBloc<SaveWatchlistEvent, SaveWatchlistState>
    implements SaveWatchlistBloc {}

void main() {
  late MoviesDetailBloc mockMoviesDetailBloc;
  late MoviesRecommendationsBloc mockMoviesRecommendationsBloc;
  late SaveWatchlistBloc mockSaveWatchlistBloc;

  setUp(() {
    mockMoviesDetailBloc = MockMoviesDetailBloc();
    mockMoviesRecommendationsBloc = MockMoviesRecommendationsBloc();
    mockSaveWatchlistBloc = MockSaveWatchlistBloc();
  });

  final testMovie = Movie(
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

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (c) => mockMoviesDetailBloc),
        BlocProvider(create: (c) => mockMoviesRecommendationsBloc),
        BlocProvider(create: (c) => mockSaveWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movies Detail Page', () {
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(const MoviesDetailState(
          status: MovieDetailStatus.loaded, movie: testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state).thenReturn(
          MoviesRecommendationsState(
              status: MovieDetailStatus.loaded, movie: [testMovie]));
      when(() => mockSaveWatchlistBloc.state).thenReturn(
          const SaveWatchlistState(
              status: MovieDetailStatus.loaded,
              isAddedToWatchlist: false,
              successMessage: 'Success',
              message: 'Success'));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(const MoviesDetailState(
          status: MovieDetailStatus.loaded, movie: testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state).thenReturn(
          MoviesRecommendationsState(
              status: MovieDetailStatus.loaded, movie: [testMovie]));
      when(() => mockSaveWatchlistBloc.state).thenReturn(
          const SaveWatchlistState(
              status: MovieDetailStatus.loaded,
              isAddedToWatchlist: true,
              successMessage: 'Success',
              message: 'Success'));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(const MoviesDetailState(
          status: MovieDetailStatus.loaded, movie: testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state).thenReturn(
          MoviesRecommendationsState(
              status: MovieDetailStatus.loaded, movie: [testMovie]));

      when(() => mockSaveWatchlistBloc.state).thenReturn(
          const SaveWatchlistState(
              status: MovieDetailStatus.loaded,
              isAddedToWatchlist: false,
              successMessage: 'Added to Watchlist',
              message: 'Added to Watchlist'));
      whenListen(
          mockSaveWatchlistBloc,
          Stream.fromIterable([
            const SaveWatchlistState(status: MovieDetailStatus.loading),
            const SaveWatchlistState(
                status: MovieDetailStatus.loaded,
                isAddedToWatchlist: false,
                successMessage: 'Added to Watchlist',
                message: 'Added to Watchlist')
          ]));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      // expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(const MoviesDetailState(
          status: MovieDetailStatus.loaded, movie: testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state).thenReturn(
          MoviesRecommendationsState(
              status: MovieDetailStatus.loaded, movie: [testMovie]));
      when(() => mockSaveWatchlistBloc.state).thenReturn(
          const SaveWatchlistState(
              status: MovieDetailStatus.error,
              isAddedToWatchlist: false,
              errorMessage: 'Failed',
              message: 'Failed'));
      whenListen(
          mockSaveWatchlistBloc,
          Stream.fromIterable([
            const SaveWatchlistState(status: MovieDetailStatus.loading),
            const SaveWatchlistState(
                status: MovieDetailStatus.error,
                isAddedToWatchlist: false,
                errorMessage: 'Failed',
                message: 'Failed')
          ]));

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });
}
