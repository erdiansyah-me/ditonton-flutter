import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/popular_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'popular_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetPopularSeries();
    notifier = PopularSeriesNotifier(mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('popular tvseries notifier', () {
    test('should change state to loading when usecase is called', () {
      when(mockGetPopularSeries.execute())
        .thenAnswer((realInvocation) async => Right(testTvseriesList));
      
      notifier.fetchPopularSeries();
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });
    test('should return popular tvseries list when data is successful', () async {
      when(mockGetPopularSeries.execute())
        .thenAnswer((realInvocation) async => Right(testTvseriesList));

      await notifier.fetchPopularSeries();

      expect(notifier.state, RequestState.Loaded);
      expect(notifier.series, testTvseriesList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularSeries.execute())
        .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));

        await notifier.fetchPopularSeries();

        expect(notifier.state, RequestState.Error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
    });
  });
}
