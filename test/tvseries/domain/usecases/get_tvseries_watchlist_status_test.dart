import 'package:ditonton/domain/usecases/tvseries/get_tvseries_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesWatchListStatus usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetSeriesWatchListStatus(mockTvseriesRepository);
  });
  final tId = 1;
  test('should get watchlist status for tvseries from repository', () async {
    when(mockTvseriesRepository.isAddedToSeriesWatchlist(tId))
      .thenAnswer((_) async => true);
    final result = await usecase.execute(tId);
    expect(result, true);
  });
}