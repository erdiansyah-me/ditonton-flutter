import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/cubit/movie_detail/movie_detail_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailCubit = MovieDetailCubit(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });
  final tId = 1;

  group('movie detail cubit', () {
    test('initial state empty', () {
      expect(movieDetailCubit.state, DetailEmpty());
    });
    blocTest<MovieDetailCubit, MovieDetailState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((realInvocation) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((realInvocation) async => Right(testMovieList));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((realInvocation) async => true);
        return movieDetailCubit;
      } ,
      act: (cubit) => movieDetailCubit.fetchMovieDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailHasData(testMovieDetail, testMovieList, true),
      ],
    );
    blocTest<MovieDetailCubit, MovieDetailState>(
      'emits [Loading, error] when one of get data failed.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((realInvocation) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((realInvocation) async => false);
        return movieDetailCubit;
      } ,
      act: (cubit) => movieDetailCubit.fetchMovieDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'emits [Loading, error] when get data failed.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((realInvocation) async => false);
        return movieDetailCubit;
      } ,
      act: (cubit) => movieDetailCubit.fetchMovieDetail(tId),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
    );
  });
}
