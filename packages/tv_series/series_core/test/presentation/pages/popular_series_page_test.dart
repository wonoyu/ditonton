import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

void main() {
  late PopularSeriesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (c) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(const PopularSeriesState(status: SeriesBlocState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularSeriesState(
        status: SeriesBlocState.loaded, series: tSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const PopularSeriesState(
        status: SeriesBlocState.error, message: 'Server Failure'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
