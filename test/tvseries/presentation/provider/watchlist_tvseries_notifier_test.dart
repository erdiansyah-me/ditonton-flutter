import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/watchlist_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'watchlist_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistTvseriesNotifier provider;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistTvseriesNotifier(
      getWatchlistSeries: mockGetWatchlistSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('watchlist tvseries', () {
    test('should change data when call succeed', () async {
      when(mockGetWatchlistSeries.execute()).thenAnswer((_) async => Right([testWatchlistSeries]));

      await provider.fetchWatchlistSeries();

      expect(provider.seriesWatchlistState , RequestState.Loaded);
      expect(provider.seriesWatchlist, [testWatchlistSeries]);
      expect(listenerCallCount, 2);
    });

    test('should return error when call failed', () async {
      when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));

      await provider.fetchWatchlistSeries();

      expect(provider.seriesWatchlistState, RequestState.Error);
      expect(provider.message, 'Database Failure');
      expect(listenerCallCount, 2);
    });
  });
}