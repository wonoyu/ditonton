import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

class SeriesDetail extends Equatable {
  const SeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String lastAirDate;
  final EpisodeToAir? lastEpisodeToAir;
  final EpisodeToAir? nextEpisodeToAir;
  final String name;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        seasons,
      ];
}
