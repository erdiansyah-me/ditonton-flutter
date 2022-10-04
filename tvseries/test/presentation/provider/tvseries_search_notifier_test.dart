
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/usecase/search_tvseries.dart';
import 'package:tvseries/presentation/provider/tvseries_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late TvseriesSearchNotifier provider;
  late MockSearchSeries mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeries();
    provider = TvseriesSearchNotifier(searchSeries: mockSearchSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });
  final tQuery = 'attack on titan';

  group('tvseries search notifier', () {
    test('should change state to loading when usecase called', () async {
      when(mockSearchSeries.execute(tQuery)).thenAnswer((_) async => Right(testTvseriesList));
      
      provider.fetchTvseriesSearch(tQuery);

      expect(provider.state, RequestState.Loading);
    });

    test('should change search result when data founded', () async {
      when(mockSearchSeries.execute(tQuery)).thenAnswer((_) async => Right(testTvseriesList));
      
      await provider.fetchTvseriesSearch(tQuery);

      expect(provider.state, RequestState.Loaded);
      expect(provider.searchSeriesResult, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });


}
