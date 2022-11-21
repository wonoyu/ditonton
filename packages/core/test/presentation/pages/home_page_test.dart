import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/change_list_to_show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';

class MockChangeListToShowBloc
    extends MockBloc<ChangeListToShowEvent, ChangeListToShowState>
    implements ChangeListToShowBloc {}

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
  late ChangeListToShowBloc changeListToShowBloc;
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    changeListToShowBloc = MockChangeListToShowBloc();
    nowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
    popularMoviesBloc = MockPopularMoviesBloc();
    topRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (c) => changeListToShowBloc),
      BlocProvider(create: (c) => nowPlayingMoviesBloc),
      BlocProvider(create: (c) => popularMoviesBloc),
      BlocProvider(create: (c) => topRatedMoviesBloc),
    ], child: MaterialApp(home: body));
  }

  // testWidgets('Should find text "Now Playing" when isMovies is true',
  //     (WidgetTester tester) async {
  //   when(() => changeListToShowBloc.state)
  //       .thenReturn(const ChangeListToShowState(isMovies: false));
  //   when(() => nowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesState(
  //       status: MovieListStatus.loaded, movies: [testMovie]));
  //   when(() => popularMoviesBloc.state).thenReturn(PopularMoviesState(
  //       status: MovieListStatus.loaded, movies: [testMovie]));

  //   when(() => topRatedMoviesBloc.state).thenReturn(TopRatedMoviesState(
  //       status: MovieListStatus.loaded, movies: [testMovie]));

  //   await tester.pumpWidget(_makeTestableWidget(const HomePage()));

  //   final textWidget = find.text("Now Playing");

  //   expect(textWidget, findsOneWidget);
  // });

  testWidgets('Should find text "Now Playing" when isMovies is true',
      (WidgetTester tester) async {
    when(() => changeListToShowBloc.state)
        .thenReturn(const ChangeListToShowState(isMovies: true));
    when(() => nowPlayingMoviesBloc.state).thenReturn(NowPlayingMoviesState(
        status: MovieListStatus.loaded, movies: [testMovie]));
    when(() => popularMoviesBloc.state).thenReturn(PopularMoviesState(
        status: MovieListStatus.loaded, movies: [testMovie]));

    when(() => topRatedMoviesBloc.state).thenReturn(TopRatedMoviesState(
        status: MovieListStatus.loaded, movies: [testMovie]));

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    final textWidget = find.byKey(const Key("Movies Column"));

    expect(textWidget, findsOneWidget);
  });
}
