import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_core/domain/entities/movie.dart';
import 'package:movies_search/movies_search.dart';

class MockMoviesSearchBloc
    extends MockBloc<MoviesSearchEvent, MoviesSearchState>
    implements MoviesSearchBloc {}

void main() {
  late MoviesSearchBloc mockMoviesSearchBloc;

  setUp(() {
    mockMoviesSearchBloc = MockMoviesSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (c) => mockMoviesSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovieModel = Movie(
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

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  testWidgets(
      'should show circular progress indicator when textfield value is changed',
      (WidgetTester tester) async {
    when(() => mockMoviesSearchBloc.state).thenReturn(
        const MoviesSearchState(status: MoviesSearchStatus.loading));
    // when(mockNotifier.searchResult).thenReturn(<Series>[]);

    final textFieldFinder = find.byType(TextField);
    final progressIndicatorFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    await tester.enterText(textFieldFinder, tQuery);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(progressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviesSearchBloc.state).thenReturn(MoviesSearchState(
        status: MoviesSearchStatus.loaded, searchResult: tMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockMoviesSearchBloc.state).thenReturn(const MoviesSearchState(
        status: MoviesSearchStatus.error, message: 'Error message'));

    final expandedFinder = find.byKey(const Key('Error Message'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(expandedFinder, findsOneWidget);
  });
}
