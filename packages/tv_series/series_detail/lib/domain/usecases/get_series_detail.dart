import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series_core/series_core.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) async {
    return repository.getSeriesDetail(id);
  }
}
