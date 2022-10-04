import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecase/save_tvseries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late SaveSeriesWatchlist usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SaveSeriesWatchlist(mockTvseriesRepository);
  });

  test('should save tvseries watchlist to repository', () async {
    when(mockTvseriesRepository.saveSeriesWatchlist(testTvseriesDetail))
      .thenAnswer((_) async => Right('Added to Watchlist'));

  final result = await usecase.execute(testTvseriesDetail);

  verify(mockTvseriesRepository.saveSeriesWatchlist(testTvseriesDetail));
  expect(result, Right('Added to Watchlist'));
  });
}