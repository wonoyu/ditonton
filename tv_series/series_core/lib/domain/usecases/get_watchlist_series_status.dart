import 'package:series_core/series_core.dart';

class GetWatchlistSeriesStatus {
  final SeriesRepository repository;

  GetWatchlistSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
