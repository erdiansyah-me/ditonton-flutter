import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/provider/top_rated_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'top_rated_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    notifier = TopRatedSeriesNotifier(mockGetTopRatedSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('TopRated tvseries notifier', () {
    test('should change state to loading when usecase is called', () {
      when(mockGetTopRatedSeries.execute())
        .thenAnswer((realInvocation) async => Right(testTvseriesList));
      
      notifier.fetchTopRatedSeries();
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });
    test('should return TopRated tvseries list when data call succeed', () async {
      when(mockGetTopRatedSeries.execute())
        .thenAnswer((realInvocation) async => Right(testTvseriesList));

      await notifier.fetchTopRatedSeries();

      expect(notifier.state, RequestState.Loaded);
      expect(notifier.series, testTvseriesList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data call failed', () async {
      when(mockGetTopRatedSeries.execute())
        .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));

        await notifier.fetchTopRatedSeries();

        expect(notifier.state, RequestState.Error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
    });
  });
}