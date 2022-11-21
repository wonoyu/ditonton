import 'package:flutter/foundation.dart';

class ChangeListToShowNotifier extends ChangeNotifier {
  String _message = '';
  String get message => _message;

  bool _isMovies = false;
  bool get isMovies => _isMovies;

  void changeListToSeries() {
    _message = "Changed to TV Series";
    _isMovies = false;
    notifyListeners();
  }

  void changeListToMovies() {
    _message = "Changed to Movies";
    _isMovies = true;
    notifyListeners();
  }
}
