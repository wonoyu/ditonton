import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistSeriesBloc
    extends MockBloc<WatchlistSeriesEvent, WatchlistSeriesState>
    implements WatchlistSeriesBloc {}

void main() {
  late WatchlistSeriesBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistSeriesBloc();
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
        const WatchlistSeriesState(status: SeriesBlocState.loading));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistSeriesState(
        status: SeriesBlocState.loaded, series: tSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when data is loaded but empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const WatchlistSeriesState(
        status: SeriesBlocState.loaded, series: <Series>[]));

    final listViewFinder = find.byKey(const Key('no_watchlist'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const WatchlistSeriesState(
        status: SeriesBlocState.error, message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
