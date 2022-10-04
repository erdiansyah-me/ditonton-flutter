import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecase/remove_tvseries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late RemoveSeriesWatchlist usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = RemoveSeriesWatchlist(mockTvseriesRepository);
  });

  test('should remove tvseries watchlist from repository', () async {
    when(mockTvseriesRepository.removeSeriesWatchlist(testTvseriesDetail))
      .thenAnswer((_) async => Right('Removed from Watchlist'));

  final result = await usecase.execute(testTvseriesDetail);

  verify(mockTvseriesRepository.removeSeriesWatchlist(testTvseriesDetail));
  expect(result, Right('Removed from Watchlist'));
  });
}