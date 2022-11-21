part of 'change_list_to_show_bloc.dart';

class ChangeListToShowState extends Equatable {
  final bool isMovies;

  const ChangeListToShowState({this.isMovies = false});

  @override
  List<Object?> get props => [isMovies];
}
