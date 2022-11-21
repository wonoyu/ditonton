import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_core/movies_core.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
