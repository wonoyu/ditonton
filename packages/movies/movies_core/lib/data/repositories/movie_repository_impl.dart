import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:movies_core/movies_core.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final FirebaseCrashlytics firebaseCrashlytics;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.firebaseCrashlytics,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
