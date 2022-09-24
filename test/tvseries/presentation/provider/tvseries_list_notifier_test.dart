import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularSeries, GetOnTheAirSeries, GetTopRatedSeries])
void main() {
  late TvseriesListNotifier provider;
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = TvseriesListNotifier(
      getOnTheAirSeries: mockGetOnTheAirSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    )..addListener(() { 
        listenerCallCount += 1;
      });
  });

  group('on the air tvseries', () {
    test('empty on initial state', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });
    
    test('should get data from usecase', () async {
      when(mockGetOnTheAirSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchOnTheAirSeries();

      verify(mockGetOnTheAirSeries.execute());
    });

    test('should change state to loading when usecase called', () {
      when(mockGetOnTheAirSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchOnTheAirSeries();

      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change data list when succeed', () async {
      when(mockGetOnTheAirSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      await provider.fetchOnTheAirSeries();

      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirSeries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when load data failed', () async {
      when(mockGetOnTheAirSeries.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchOnTheAirSeries();

      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvseries', () {
    test('should get data from usecase', () async {
      when(mockGetPopularSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchPopularSeries();

      verify(mockGetPopularSeries.execute());
    });

    test('should change state to loading when usecase called', () {
      when(mockGetPopularSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchPopularSeries();

      expect(provider.popularState, RequestState.Loading);
    });

    test('should change data list when succeed', () async {
      when(mockGetPopularSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      await provider.fetchPopularSeries();

      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularSeries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when load data failed', () async {
      when(mockGetPopularSeries.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularSeries();

      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  
  group('top rated tvseries', () {
    test('should get data from usecase', () async {
      when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchTopRatedSeries();

      verify(mockGetTopRatedSeries.execute());
    });

    test('should change state to loading when usecase called', () {
      when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      provider.fetchTopRatedSeries();

      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change data list when succeed', () async {
      when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Right(testTvseriesList));

      await provider.fetchTopRatedSeries();

      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedSeries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when load data failed', () async {
      when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedSeries();

      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
