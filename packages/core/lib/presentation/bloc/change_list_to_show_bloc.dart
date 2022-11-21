import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_list_to_show_event.dart';
part 'change_list_to_show_state.dart';

class ChangeListToShowBloc
    extends Bloc<ChangeListToShowEvent, ChangeListToShowState> {
  ChangeListToShowBloc() : super(const ChangeListToShowState(isMovies: false)) {
    on<ChangeList>((event, emit) =>
        emit(ChangeListToShowState(isMovies: !state.isMovies)));
  }
}
