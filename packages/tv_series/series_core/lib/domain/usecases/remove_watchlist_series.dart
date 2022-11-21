import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class RemoveWatchlistSeries {
  final SeriesRepository repository;

  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) async {
    return repository.removeWatchlist(series);
  }
}
