import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_core/series_core.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_series_page_test.dart';
import 'popular_series_page_test.dart';
import 'top_rated_series_page_test.dart';

void main() {
  late OnTheAirSeriesBloc onTheAirSeriesBloc;
  late PopularSeriesBloc popularSeriesBloc;
  late TopRatedSeriesBloc topRatedSeriesBloc;

  setUp(() {
    onTheAirSeriesBloc = MockOnTheAirSeriesBloc();
    popularSeriesBloc = MockPopularSeriesBloc();
    topRatedSeriesBloc = MockTopRatedSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (c) => onTheAirSeriesBloc),
          BlocProvider(create: (c) => popularSeriesBloc),
          BlocProvider(create: (c) => topRatedSeriesBloc),
        ],
        child: MaterialApp(
            home: Material(child: SingleChildScrollView(child: body))));
  }

  group('home series', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(() => onTheAirSeriesBloc.state).thenReturn(
          const OnTheAirSeriesState(status: SeriesBlocState.loading));
      when(() => popularSeriesBloc.state).thenReturn(
          const PopularSeriesState(status: SeriesBlocState.loading));
      when(() => topRatedSeriesBloc.state).thenReturn(
          const TopRatedSeriesState(status: SeriesBlocState.loading));

      final progressOnTheAirFinder =
          find.byKey(const Key('Loading Now Playing'));
      final progressPopularFinder = find.byKey(const Key('Loading Popular'));
      final progressTopRatedFinder = find.byKey(const Key('Loading Top Rated'));

      await tester.pumpWidget(_makeTestableWidget(const HomeSeriesPage()));

      expect(progressOnTheAirFinder, findsOneWidget);
      expect(progressPopularFinder, findsOneWidget);
      expect(progressTopRatedFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => onTheAirSeriesBloc.state).thenReturn(OnTheAirSeriesState(
          status: SeriesBlocState.loaded, series: tSeriesList));
      when(() => popularSeriesBloc.state).thenReturn(PopularSeriesState(
          status: SeriesBlocState.loaded, series: tSeriesList));
      when(() => topRatedSeriesBloc.state).thenReturn(TopRatedSeriesState(
          status: SeriesBlocState.loaded, series: tSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const HomeSeriesPage()));

      expect(listViewFinder, findsNWidgets(3));
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => onTheAirSeriesBloc.state).thenReturn(const OnTheAirSeriesState(
          status: SeriesBlocState.error, message: 'Error message'));
      when(() => popularSeriesBloc.state).thenReturn(const PopularSeriesState(
          status: SeriesBlocState.error, message: 'Error message'));
      when(() => topRatedSeriesBloc.state).thenReturn(const TopRatedSeriesState(
          status: SeriesBlocState.error, message: 'Error message'));

      final onTheAirFinder = find.byKey(const Key('Error On The Air'));
      final popularFinder = find.byKey(const Key('Error Popular'));
      final topRatedFinder = find.byKey(const Key('Error Top Rated'));

      await tester.pumpWidget(_makeTestableWidget(const HomeSeriesPage()));

      expect(onTheAirFinder, findsOneWidget);
      expect(popularFinder, findsOneWidget);
      expect(topRatedFinder, findsOneWidget);
    });
  });
}
