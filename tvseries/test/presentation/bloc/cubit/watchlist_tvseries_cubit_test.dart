import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/get_watchlist_tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/watchlist_tvseries/watchlist_tvseries_cubit.dart';

import '../../../dummy_data/tvseries_dummy_objects.dart';
import 'watchlist_tvseries_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistTvseriesCubit watchlistTvseriesCubit;
  late MockGetWatchlistSeries mockGetWatchlistSeries;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    watchlistTvseriesCubit =  WatchlistTvseriesCubit(mockGetWatchlistSeries);
  });

  group('Watchlist Tvseries cubit', () {
    test('initial state empty', () {
      expect(watchlistTvseriesCubit.state, WatchlistEmpty());
    });
    blocTest<WatchlistTvseriesCubit, WatchlistTvseriesState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetWatchlistSeries.execute()).thenAnswer((realInvocation) async => Right(testTvseriesList));
        return watchlistTvseriesCubit;
      },
      act: (cubit) => cubit.fetchWatchlistSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(testTvseriesList),
      ],
    );
    blocTest<WatchlistTvseriesCubit, WatchlistTvseriesState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetWatchlistSeries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return watchlistTvseriesCubit;
      },
      act: (cubit) => cubit.fetchWatchlistSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistLoading(),
        WatchlistError('Server Failure'),
      ],
    );
  });
}