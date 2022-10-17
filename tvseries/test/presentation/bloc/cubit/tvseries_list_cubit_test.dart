import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/get_on_the_air_tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/tvseries_list/tvseries_list_cubit.dart';

import '../../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_list_cubit_test.mocks.dart';

@GenerateMocks([GetPopularSeries, GetOnTheAirSeries, GetTopRatedSeries])
void main() {
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TvseriesListCubit tvseriesListCubit;

  setUp(() {
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    tvseriesListCubit = TvseriesListCubit(
      mockGetOnTheAirSeries,
      mockGetPopularSeries,
      mockGetTopRatedSeries,
    );
  });

  group('List Tvseries cubit', () {
    test('initial state empty', () {
      expect(tvseriesListCubit.state, ListEmpty());
    });

    blocTest<TvseriesListCubit, TvseriesListState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((realInvocation) async => Right(testTvseriesList));
        when(mockGetPopularSeries.execute())
            .thenAnswer((realInvocation) async => Right(testTvseriesList));
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((realInvocation) async => Right(testTvseriesList));
        return tvseriesListCubit;
      },
      act: (cubit) => cubit.fetchListSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ListLoading(),
        ListHasData(
          onTheAirSeriesResult: testTvseriesList,
          popularSeriesResult: testTvseriesList,
          topRatedSeriesResult: testTvseriesList,
        ),
      ],
    );
    blocTest<TvseriesListCubit, TvseriesListState>(
      'emits [Loading, error] when one of get data failed.',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetPopularSeries.execute())
            .thenAnswer((realInvocation) async => Right(testTvseriesList));
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((realInvocation) async => Right(testTvseriesList));
        return tvseriesListCubit;
      },
      act: (cubit) => cubit.fetchListSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ListLoading(),
        ListHasData(onTheAirSeriesResult: const [], popularSeriesResult: testTvseriesList, topRatedSeriesResult: testTvseriesList),
      ],
    );
    blocTest<TvseriesListCubit, TvseriesListState>(
      'emits [Loading, error] when all get data failed.',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed  Load Data')));
        when(mockGetPopularSeries.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed  Load Data')));
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed  Load Data')));
        return tvseriesListCubit;
      },
      act: (cubit) => cubit.fetchListSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ListLoading(),
        const ListError('Failed Load Data'),
      ],
    );
  });
}