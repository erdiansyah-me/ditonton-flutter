import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_recommendation.dart';
import 'package:tvseries/domain/usecase/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecase/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecase/save_tvseries_watchlist.dart';
import 'package:tvseries/presentation/bloc/cubit/tvseries_detail/tvseries_detail_cubit.dart';

import '../../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetTvseriesDetail,
  GetSeriesRecommendation,
  GetSeriesWatchListStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late TvseriesDetailCubit tvseriesDetailCubit;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetSeriesRecommendation mockGetSeriesRecommendation;
  late MockGetSeriesWatchListStatus mockGetSeriesWatchListStatus;
  late MockSaveSeriesWatchlist mockSaveSeriesWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveSeriesWatchlist;

  setUp(() {
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetSeriesRecommendation = MockGetSeriesRecommendation();
    mockGetSeriesWatchListStatus = MockGetSeriesWatchListStatus();
    mockSaveSeriesWatchlist = MockSaveSeriesWatchlist();
    mockRemoveSeriesWatchlist = MockRemoveSeriesWatchlist();
    tvseriesDetailCubit = TvseriesDetailCubit(
      mockGetTvseriesDetail,
      mockGetSeriesWatchListStatus,
      mockGetSeriesRecommendation,
      mockSaveSeriesWatchlist,
      mockRemoveSeriesWatchlist,
    );
  });
  final tId = 1;

  group('Tvseries detail cubit', () {
    test('initial state empty', () {
      expect(tvseriesDetailCubit.state, DetailEmpty());
    });
    blocTest<TvseriesDetailCubit, TvseriesDetailState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetTvseriesDetail.execute(tId)).thenAnswer((realInvocation) async => Right(testTvseriesDetail));
        when(mockGetSeriesRecommendation.execute(tId)).thenAnswer((realInvocation) async => Right(testTvseriesList));
        when(mockGetSeriesWatchListStatus.execute(tId)).thenAnswer((realInvocation) async => true);
        return tvseriesDetailCubit;
      } ,
      act: (cubit) => tvseriesDetailCubit.fetchTvseriesDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailHasData(testTvseriesDetail, testTvseriesList, true),
      ],
    );
    blocTest<TvseriesDetailCubit, TvseriesDetailState>(
      'emits [Loading, error] when one of get data failed.',
      build: () {
        when(mockGetTvseriesDetail.execute(tId)).thenAnswer((realInvocation) async => Right(testTvseriesDetail));
        when(mockGetSeriesRecommendation.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetSeriesWatchListStatus.execute(tId)).thenAnswer((realInvocation) async => false);
        return tvseriesDetailCubit;
      } ,
      act: (cubit) => tvseriesDetailCubit.fetchTvseriesDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
    );

    blocTest<TvseriesDetailCubit, TvseriesDetailState>(
      'emits [Loading, error] when get data failed.',
      build: () {
        when(mockGetTvseriesDetail.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetSeriesRecommendation.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetSeriesWatchListStatus.execute(tId)).thenAnswer((realInvocation) async => false);
        return tvseriesDetailCubit;
      } ,
      act: (cubit) => tvseriesDetailCubit.fetchTvseriesDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
    );
  });
}