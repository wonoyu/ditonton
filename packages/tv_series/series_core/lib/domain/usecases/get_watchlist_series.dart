import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class GetWatchlistSeries {
  final SeriesRepository repository;

  GetWatchlistSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() async {
    return repository.getWatchlistSeries();
  }
}
