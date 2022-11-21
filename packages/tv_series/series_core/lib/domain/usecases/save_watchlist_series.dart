import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) async {
    return repository.saveWatchlist(series);
  }
}
