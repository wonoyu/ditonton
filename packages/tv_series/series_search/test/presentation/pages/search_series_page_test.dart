import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_core/series_core.dart';
import 'package:series_search/series_search.dart';

class MockSeriesSearchBloc
    extends MockBloc<SearchSeriesEvent, SearchSeriesState>
    implements SearchSeriesBloc {}

void main() {
  late SearchSeriesBloc mockSeriesSearchBloc;

  setUp(() {
    mockSeriesSearchBloc = MockSeriesSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (c) => mockSeriesSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tSeriesModel = Series(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: const [18, 9648],
    id: 31917,
    originalName: 'Pretty Little Liars',
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    firstAirDate: '2010-06-08',
    name: 'Pretty Little Liars',
    voteAverage: 5.04,
    voteCount: 133,
  );
  final tSeriesList = <Series>[tSeriesModel];
  const tQuery = 'pretty little liars';

  testWidgets(
      'should show circular progress indicator when textfield value is changed',
      (WidgetTester tester) async {
    when(() => mockSeriesSearchBloc.state)
        .thenReturn(const SearchSeriesState(status: SeriesBlocState.loading));
    // when(mockNotifier.searchResult).thenReturn(<Series>[]);

    final textFieldFinder = find.byType(TextField);
    final progressIndicatorFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchSeriesPage()));

    await tester.enterText(textFieldFinder, tQuery);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(progressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSeriesSearchBloc.state).thenReturn(SearchSeriesState(
        status: SeriesBlocState.loaded, searchResult: tSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSeriesSearchBloc.state).thenReturn(const SearchSeriesState(
        status: SeriesBlocState.error, message: 'Error message'));

    final expandedFinder = find.byKey(const Key('Error Message'));

    await tester.pumpWidget(_makeTestableWidget(const SearchSeriesPage()));

    expect(expandedFinder, findsOneWidget);
  });
}
