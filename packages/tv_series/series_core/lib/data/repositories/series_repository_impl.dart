import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:series_core/series_core.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  SeriesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.firebaseCrashlytics});

  final SeriesRemoteDataSource remoteDataSource;
  final SeriesLocalDataSource localDataSource;
  final FirebaseCrashlytics firebaseCrashlytics;

  @override
  Future<Either<Failure, List<Series>>> getOnTheAirSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirSeries();
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
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getSeriesRecommendations(id);
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
  Future<Either<Failure, List<Series>>> getPopularSeries() async {
    try {
      final result = await remoteDataSource.getPopularSeries();
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
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getSeriesDetail(id);
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
  Future<Either<Failure, List<Series>>> getTopRatedSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedSeries();
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
  Future<Either<Failure, List<Series>>> getWatchlistSeries() async {
    final result = await localDataSource.getWatchlistSeries();
    return Right(result.map((model) => model.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail series) async {
    try {
      final result =
          await localDataSource.removeWatchlist(SeriesTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail series) async {
    try {
      final result =
          await localDataSource.insertWatchlist(SeriesTable.fromEntity(series));
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
  Future<Either<Failure, List<Series>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ServerFailure(''));
    } on SocketException catch (e, st) {
      firebaseCrashlytics.recordError(e, st);
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
