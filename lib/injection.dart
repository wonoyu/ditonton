import 'package:core/core.dart';
import 'package:core/presentation/bloc/change_list_to_show_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init(IOClient ioClient) {
  // bloc
  locator.registerFactory(() => ChangeListToShowBloc());
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMoviesBloc(locator()));
  locator.registerFactory(() => MoviesDetailBloc(locator()));
  locator.registerFactory(() => MoviesRecommendationsBloc(locator()));
  locator.registerFactory(
      () => SaveWatchlistBloc(locator(), locator(), locator()));
  locator.registerFactory(() => MoviesSearchBloc(locator()));
  locator.registerFactory(() => OnTheAirSeriesBloc(locator()));
  locator.registerFactory(() => PopularSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistSeriesBloc(locator()));
  locator.registerFactory(() => SeriesDetailBloc(locator()));
  locator.registerFactory(() => SeriesRecommendationsBloc(locator()));
  locator.registerFactory(
      () => SaveWatchlistSeriesBloc(locator(), locator(), locator()));
  locator.registerFactory(() => SearchSeriesBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      firebaseCrashlytics: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(() => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      firebaseCrashlytics: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<http.Client>(() => ioClient);

  // firebase crashlytics instance
  locator.registerLazySingleton(() => FirebaseCrashlytics.instance);
}
