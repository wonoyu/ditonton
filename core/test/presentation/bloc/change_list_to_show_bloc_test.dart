import 'package:core/presentation/bloc/change_list_to_show_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChangeListToShowBloc changeListToShowBloc;

  setUp(() {
    changeListToShowBloc = ChangeListToShowBloc();
  });

  blocTest<ChangeListToShowBloc, ChangeListToShowState>(
    'Should emit [ChangeListToShowState] when ChangeList is added.',
    build: () => changeListToShowBloc,
    act: (bloc) => bloc.add(ChangeList()),
    expect: () =>
        <ChangeListToShowState>[const ChangeListToShowState(isMovies: true)],
  );
}
