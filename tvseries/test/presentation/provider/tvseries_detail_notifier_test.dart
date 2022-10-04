import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_recommendation.dart';
import 'package:tvseries/domain/usecase/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecase/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecase/save_tvseries_watchlist.dart';
import 'package:tvseries/presentation/provider/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvseriesDetail,
  GetSeriesRecommendation,
  GetSeriesWatchListStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late TvseriesDetailNotifier provider;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetSeriesRecommendation mockGetSeriesRecommendation;
  late MockGetSeriesWatchListStatus mockGetSeriesWatchListStatus;
  late MockSaveSeriesWatchlist mockSaveSeriesWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveSeriesWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetSeriesRecommendation = MockGetSeriesRecommendation();
    mockGetSeriesWatchListStatus = MockGetSeriesWatchListStatus();
    mockSaveSeriesWatchlist = MockSaveSeriesWatchlist();
    mockRemoveSeriesWatchlist = MockRemoveSeriesWatchlist();
    provider = TvseriesDetailNotifier(
      getTvseriesDetail: mockGetTvseriesDetail,
      getSeriesRecommendation: mockGetSeriesRecommendation,
      getSeriesWatchListStatus: mockGetSeriesWatchListStatus,
      saveSeriesWatchlist: mockSaveSeriesWatchlist,
      removeSeriesWatchlist: mockRemoveSeriesWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final _testTvseries = <Tvseries>[testTvseries];
  void _arrangeUsecase() {
    when(mockGetTvseriesDetail.execute(tId))
      .thenAnswer((_) async => Right(testTvseriesDetail));
    when(mockGetSeriesRecommendation.execute(tId))
      .thenAnswer((_) async => Right(testTvseriesList));
  }

  group('Get Tvseries Detail', () {
    test('should get data from usecase', () async {
      _arrangeUsecase();

      await provider.fetchTvseriesDetail(tId);

      verify(mockGetTvseriesDetail.execute(tId));
      verify(mockGetSeriesRecommendation.execute(tId));
    });
    test('change state to loading when usecase called', () {
      _arrangeUsecase();

      provider.fetchTvseriesDetail(tId);

      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvseries detail when data is successful', () async {
      _arrangeUsecase();

      await provider.fetchTvseriesDetail(tId);

      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.series, testTvseriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tvseries when data is successful', () async {
      _arrangeUsecase();

      await provider.fetchTvseriesDetail(tId);

      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.seriesRecommendation, _testTvseries);
    });
  });

  group('Get Tvseries Recommendation', () {
    test('should get data from usecase', () async {
      _arrangeUsecase();

      await provider.fetchTvseriesDetail(tId);

      verify(mockGetSeriesRecommendation.execute(tId));
      expect(provider.seriesRecommendation, _testTvseries);
    });

    test('should change recommendation tvseries when data is successful', () async {
      _arrangeUsecase();

      await provider.fetchTvseriesDetail(tId);

      expect(provider.seriesRecommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendation, _testTvseries);
    });

    test('should update error message when request succeed', () async {
      when(mockGetTvseriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvseriesDetail));
      when(mockGetSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Failed')));

      await provider.fetchTvseriesDetail(tId);

      expect(provider.seriesRecommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get watchlist status', () async {
      when(mockGetSeriesWatchListStatus.execute(tId)).thenAnswer((_) async => true);

      await provider.loadSeriesWatchlistStatus(tId);

      expect(provider.isAddedtoSeriesWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveSeriesWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      
      await provider.addSeriesWatchlist(testTvseriesDetail);
      
      verify(mockSaveSeriesWatchlist.execute(testTvseriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockRemoveSeriesWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      
      await provider.removeFromSeriesWatchlist(testTvseriesDetail);
      
      verify(mockRemoveSeriesWatchlist.execute(testTvseriesDetail));
    });

    test('should update watchlist status when add watchlist succeed', () async {
      when(mockSaveSeriesWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      
      await provider.addSeriesWatchlist(testTvseriesDetail);
      
      verify(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id));
      expect(provider.isAddedtoSeriesWatchlist, true);
      expect(provider.seriesWatchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist status when add watchlist failed', () async {
      
      when(mockSaveSeriesWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      
      await provider.addSeriesWatchlist(testTvseriesDetail);
      
      expect(provider.seriesWatchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist status when remove watchlist failed', () async {
      
      when(mockRemoveSeriesWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetSeriesWatchListStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      
      await provider.removeFromSeriesWatchlist(testTvseriesDetail);
      
      expect(provider.seriesWatchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error showing Tvseries detail', () {
    test('should return error when data is failed to call', () async {
      when(mockGetTvseriesDetail.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Right(testTvseriesList));

      await provider.fetchTvseriesDetail(tId);

      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
