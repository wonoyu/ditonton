import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_core/movies_core.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

void main() {
  late WatchlistMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (c) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        const WatchlistMoviesState(status: WatchlistMoviesStatus.loading));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistMoviesState(
        status: WatchlistMoviesStatus.loaded, watchlistMovies: testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when data is loaded but empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const WatchlistMoviesState(
        status: WatchlistMoviesStatus.loaded, watchlistMovies: <Movie>[]));

    final listViewFinder = find.byKey(const Key('no_watchlist'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const WatchlistMoviesState(
        status: WatchlistMoviesStatus.error, message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
