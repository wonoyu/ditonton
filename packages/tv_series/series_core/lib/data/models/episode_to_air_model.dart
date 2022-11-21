import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

class EpisodeToAirModel extends Equatable {
  const EpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final double voteCount;

  factory EpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      EpisodeToAirModel(
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        productionCode: json['production_code'],
        seasonNumber: json['season_number'],
        stillPath: json['still_path'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_number': episodeNumber,
        'id': id,
        'name': name,
        'overview': overview,
        'production_code': productionCode,
        'season_number': seasonNumber,
        'still_path': stillPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  EpisodeToAir toEntity() => EpisodeToAir(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount);

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
