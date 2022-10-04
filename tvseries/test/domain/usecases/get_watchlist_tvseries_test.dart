import 'package:dartz/dartz.dart';

import 'package:tvseries/domain/usecase/get_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetWatchlistSeries(mockTvseriesRepository);
  });
  test('should get list of top rated Tvseries from the repository', () async {
    when(mockTvseriesRepository.getWatchlistSeries()).thenAnswer((_) async => Right(testTvseriesList));

    final result = await usecase.execute();

    expect(result, Right(testTvseriesList));
  });
}