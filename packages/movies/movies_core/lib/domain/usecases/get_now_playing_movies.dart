import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_core/movies_core.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
