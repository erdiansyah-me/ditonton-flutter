import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TvseriesRepositoryImpl implements TvseriesRepository {
  final TvseriesRemoteDataSource seriesRemoteDataSource;
  final TvseriesLocalDataSource seriesLocalDataSource;

  TvseriesRepositoryImpl({
    required this.seriesRemoteDataSource,
    required this.seriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Tvseries>>> getOnTheAirSeries() async {
    try {
      final result = await seriesRemoteDataSource.getOnTheAirSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getPopularSeries() async {
    try {
      final result = await seriesRemoteDataSource.getPopularSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getRecommendationSeries(int id) async {
    try {
      final result = await seriesRemoteDataSource.getRecommendationSeries(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getTopRatedSeries() async {
    try {
      final result = await seriesRemoteDataSource.getTopRatedSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }

  @override
  Future<Either<Failure, TvseriesDetail>> getTvseriesDetail(int id) async {
    try {
      final result = await seriesRemoteDataSource.getTvseriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getWatchlistSeries() async {
    final result = await seriesLocalDataSource.getWatchlistSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToSeriesWatchlist(int id) async {
    final result = await seriesLocalDataSource.getSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeSeriesWatchlist(TvseriesDetail tvseries) async {
    try {
      final result = await seriesLocalDataSource.removeSeriesWatchlist(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveSeriesWatchlist(TvseriesDetail tvseries) async {
    try {
      final result = await seriesLocalDataSource.insertSeriesWatchlist(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> searchSeries(String query) async {
    try {
      final result = await seriesRemoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to Connect to Internet'));
    }
  }
  
}