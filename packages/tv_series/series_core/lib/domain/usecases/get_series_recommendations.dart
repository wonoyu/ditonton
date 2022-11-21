import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(int id) async {
    return repository.getSeriesRecommendations(id);
  }
}
