import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirSeriesBloc
    extends MockBloc<OnTheAirSeriesEvent, OnTheAirSeriesState>
    implements OnTheAirSeriesBloc {}

void main() {
  late OnTheAirSeriesBloc mockOnTheAirSeriesBloc;

  setUp(() {
    mockOnTheAirSeriesBloc = MockOnTheAirSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (c) => mockOnTheAirSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state)
        .thenReturn(const OnTheAirSeriesState(status: SeriesBlocState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state).thenReturn(OnTheAirSeriesState(
        status: SeriesBlocState.loaded, series: tSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state).thenReturn(
        const OnTheAirSeriesState(
            status: SeriesBlocState.error, message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
