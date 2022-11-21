import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_core/movies_core.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    nowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
    popularMoviesBloc = MockPopularMoviesBloc();
    topRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (c) => nowPlayingMoviesBloc),
          BlocProvider(create: (c) => popularMoviesBloc),
          BlocProvider(create: (c) => topRatedMoviesBloc),
        ],
        child: MaterialApp(
            home: Material(child: SingleChildScrollView(child: body))));
  }

  group('home movies', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => nowPlayingMoviesBloc.state).thenReturn(
          const NowPlayingMoviesState(status: MovieListStatus.loading));
      when(() => popularMoviesBloc.state).thenReturn(
          const PopularMoviesState(status: MovieListStatus.loading));
      when(() => topRatedMoviesBloc.state).thenReturn(
          const TopRatedMoviesState(status: MovieListStatus.loading));

      final progressNowPlayingFinder =
          find.byKey(const Key('Loading Now Playing'));
      final progressPopularFinder = find.byKey(const Key('Loading Popular'));
      final progressTopRatedFinder = find.byKey(const Key('Loading Top Rated'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(progressNowPlayingFinder, findsOneWidget);
      expect(progressPopularFinder, findsOneWidget);
      expect(progressTopRatedFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => nowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesState(
          status: MovieListStatus.loaded, movies: testMovieList));
      when(() => popularMoviesBloc.state).thenReturn(PopularMoviesState(
          status: MovieListStatus.loaded, movies: testMovieList));
      when(() => topRatedMoviesBloc.state).thenReturn(TopRatedMoviesState(
          status: MovieListStatus.loaded, movies: testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(listViewFinder, findsNWidgets(3));
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => nowPlayingMoviesBloc.state).thenReturn(
          const NowPlayingMoviesState(
              status: MovieListStatus.error, message: 'Error message'));
      when(() => popularMoviesBloc.state).thenReturn(const PopularMoviesState(
          status: MovieListStatus.error, message: 'Error message'));
      when(() => topRatedMoviesBloc.state).thenReturn(const TopRatedMoviesState(
          status: MovieListStatus.error, message: 'Error message'));

      final nowPlayingFinder = find.byKey(const Key('Error Now Playing'));
      final popularFinder = find.byKey(const Key('Error Popular'));
      final topRatedFinder = find.byKey(const Key('Error Top Rated'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(nowPlayingFinder, findsOneWidget);
      expect(popularFinder, findsOneWidget);
      expect(topRatedFinder, findsOneWidget);
    });
  });
}
