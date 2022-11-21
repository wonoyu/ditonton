import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class GetOnTheAirSeries {
  final SeriesRepository repository;

  GetOnTheAirSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() async {
    return repository.getOnTheAirSeries();
  }
}
