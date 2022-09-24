import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late TvseriesRepositoryImpl repositoryImpl;
  late MockTvseriesRemoteDataSource mockTvseriesRemoteDataSource;
  late MockTvseriesLocalDataSource mockTvseriesLocalDataSource;

  setUp(() {
    mockTvseriesRemoteDataSource = MockTvseriesRemoteDataSource();
    mockTvseriesLocalDataSource = MockTvseriesLocalDataSource();
    repositoryImpl = TvseriesRepositoryImpl(
      seriesRemoteDataSource: mockTvseriesRemoteDataSource,
      seriesLocalDataSource: mockTvseriesLocalDataSource,
    );
  });
  final _testTvseriesList = <Tvseries>[testTvseries];
  final _testTvseriesModelList = <TvseriesModel>[testTvseriesModel];

  group('On the air tvseries', () {
    test('should return remote data when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.getOnTheAirSeries()).thenAnswer((_) async => _testTvseriesModelList);

      final result = await repositoryImpl.getOnTheAirSeries();

      verify(mockTvseriesRemoteDataSource.getOnTheAirSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, _testTvseriesList);
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.getOnTheAirSeries()).thenThrow(ServerException());

      final result = await repositoryImpl.getOnTheAirSeries();

      verify(mockTvseriesRemoteDataSource.getOnTheAirSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvseriesRemoteDataSource.getOnTheAirSeries())
          .thenThrow(SocketException('Failed to Connect to Internet'));
      // act
      final result = await repositoryImpl.getOnTheAirSeries();
      // assert
      verify(mockTvseriesRemoteDataSource.getOnTheAirSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('Popular tvseries', () {
    test('should return remote data when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.getPopularSeries()).thenAnswer((_) async => _testTvseriesModelList);

      final result = await repositoryImpl.getPopularSeries();

      verify(mockTvseriesRemoteDataSource.getPopularSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, _testTvseriesList);
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.getPopularSeries()).thenThrow(ServerException());

      final result = await repositoryImpl.getPopularSeries();

      verify(mockTvseriesRemoteDataSource.getPopularSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when internet can not be reached', () async {
      when(mockTvseriesRemoteDataSource.getPopularSeries()).thenThrow(SocketException('Failed to Connect to Internet'));

      final result = await repositoryImpl.getPopularSeries();

      verify(mockTvseriesRemoteDataSource.getPopularSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('Top Rated tvseries', () {
    test('should return remote data when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.getTopRatedSeries()).thenAnswer((_) async => _testTvseriesModelList);

      final result = await repositoryImpl.getTopRatedSeries();

      verify(mockTvseriesRemoteDataSource.getTopRatedSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, _testTvseriesList);
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.getTopRatedSeries()).thenThrow(ServerException());

      final result = await repositoryImpl.getTopRatedSeries();

      verify(mockTvseriesRemoteDataSource.getTopRatedSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when internet can not be reached', () async {
      when(mockTvseriesRemoteDataSource.getTopRatedSeries()).thenThrow(SocketException('Failed to Connect to Internet'));

      final result = await repositoryImpl.getTopRatedSeries();

      verify(mockTvseriesRemoteDataSource.getTopRatedSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('Get Tvseries detail', () {
    final tId = 1;

    test('should return tvseries detail when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.getTvseriesDetail(tId)).thenAnswer((_) async => testTvseriesDetailResponse);

      final result = await repositoryImpl.getTvseriesDetail(tId);

      verify(mockTvseriesRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(Right(testTvseriesDetail)));
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.getTvseriesDetail(tId)).thenThrow(ServerException());

      final result = await repositoryImpl.getTvseriesDetail(tId);

      verify(mockTvseriesRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when internet can not be reached', () async {
      when(mockTvseriesRemoteDataSource.getTvseriesDetail(tId)).thenThrow(SocketException('Failed to Connect to Internet'));

      final result = await repositoryImpl.getTvseriesDetail(tId);

      verify(mockTvseriesRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('Get tvseries recommendation', () {
    final tId = 1;
    test('should return remote data when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.getRecommendationSeries(tId)).thenAnswer((_) async => _testTvseriesModelList);

      final result = await repositoryImpl.getRecommendationSeries(tId);

      verify(mockTvseriesRemoteDataSource.getRecommendationSeries(tId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, _testTvseriesList);
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.getRecommendationSeries(tId)).thenThrow(ServerException());

      final result = await repositoryImpl.getRecommendationSeries(tId);

      verify(mockTvseriesRemoteDataSource.getRecommendationSeries(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when internet can not be reached', () async {
      when(mockTvseriesRemoteDataSource.getRecommendationSeries(tId)).thenThrow(SocketException('Failed to Connect to Internet'));

      final result = await repositoryImpl.getRecommendationSeries(tId);

      verify(mockTvseriesRemoteDataSource.getRecommendationSeries(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('search tvseries', () {
    final tQuery = 'attack on titan';
    test('should return remote data when remotedatasource call succeed', () async {
      when(mockTvseriesRemoteDataSource.searchSeries(tQuery)).thenAnswer((_) async => _testTvseriesModelList);

      final result = await repositoryImpl.searchSeries(tQuery);

      verify(mockTvseriesRemoteDataSource.searchSeries(tQuery));

      final resultList = result.getOrElse(() => []);
      expect(resultList, _testTvseriesList);
    });

    test('should return server failure when remotedatasource call failed', () async {
      when(mockTvseriesRemoteDataSource.searchSeries(tQuery)).thenThrow(ServerException());

      final result = await repositoryImpl.searchSeries(tQuery);

      verify(mockTvseriesRemoteDataSource.searchSeries(tQuery));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when internet can not be reached', () async {
      when(mockTvseriesRemoteDataSource.searchSeries(tQuery)).thenThrow(SocketException('Failed to Connect to Internet'));

      final result = await repositoryImpl.searchSeries(tQuery);

      verify(mockTvseriesRemoteDataSource.searchSeries(tQuery));
      expect(result, equals(Left(ConnectionFailure('Failed to Connect to Internet'))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving succeed', () async {
      when(mockTvseriesLocalDataSource.insertSeriesWatchlist(testTvseriesTable)).thenAnswer((_) async => 'Added to Watchlist');

      final result = await repositoryImpl.saveSeriesWatchlist(testTvseriesDetail);

      expect(result, Right('Added to Watchlist'));
    });

    test('should return database failure when saving failed', () async {
      when(mockTvseriesLocalDataSource.insertSeriesWatchlist(testTvseriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repositoryImpl.saveSeriesWatchlist(testTvseriesDetail);

      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when saving succeed', () async {
      when(mockTvseriesLocalDataSource.removeSeriesWatchlist(testTvseriesTable)).thenAnswer((_) async => 'Added to Watchlist');

      final result = await repositoryImpl.removeSeriesWatchlist(testTvseriesDetail);

      expect(result, Right('Added to Watchlist'));
    });

    test('should return database failure when saving failed', () async {
      when(mockTvseriesLocalDataSource.removeSeriesWatchlist(testTvseriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repositoryImpl.removeSeriesWatchlist(testTvseriesDetail);

      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('get watchlist tvseries status', () {
    test('should return watchlist status when data found', () async {
      final tId = 1;
      when(mockTvseriesLocalDataSource.getSeriesById(tId)).thenAnswer((_) async => null);

      final result = await repositoryImpl.isAddedToSeriesWatchlist(tId);

      expect(result, false);
    });
  });

  group('get watchlist tvseries', () {
    test('should return list of tvseries', () async {
      when(mockTvseriesLocalDataSource.getWatchlistSeries()).thenAnswer((_) async => [testTvseriesTable]);

      final result = await repositoryImpl.getWatchlistSeries();

      final resultList = result.getOrElse(() => []);

      expect(resultList, [testWatchlistSeries]);
    });
  });

}
