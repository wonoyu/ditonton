part of 'change_list_to_show_bloc.dart';

abstract class ChangeListToShowEvent extends Equatable {
  const ChangeListToShowEvent();

  @override
  List<Object> get props => [];
}

class ChangeList extends ChangeListToShowEvent {}
