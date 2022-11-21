import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

final tSeries = Series(
  backdropPath: 'backdropPath',
  genreIds: const [1, 2, 3],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final tSeriesList = [tSeries];

const tSeriesDetail = SeriesDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: "originalName",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: "overview",
  posterPath: "posterPath",
  firstAirDate: "firstAirDate",
  lastAirDate: "lastAirDate",
  lastEpisodeToAir: EpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  ),
  nextEpisodeToAir: EpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  ),
  name: "name",
  voteAverage: 1,
  voteCount: 1,
  seasons: [
    Season(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1),
  ],
);

final tWatchListSeries = Series.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const tSeriesTable = SeriesTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

final tSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
