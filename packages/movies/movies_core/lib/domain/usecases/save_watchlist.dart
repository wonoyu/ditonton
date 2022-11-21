import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_core/movies_core.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
