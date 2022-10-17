import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/top_rated_tvseries/top_rated_tvseries_cubit.dart';

import '../../../dummy_data/tvseries_dummy_objects.dart';
import 'top_rated_tvseries_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedTvseriesCubit topRatedTvseriesCubit;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedTvseriesCubit =  TopRatedTvseriesCubit(mockGetTopRatedSeries);
  });

  group('TopRated Tvseries cubit', () {
    test('initial state empty', () {
      expect(topRatedTvseriesCubit.state, TopRatedEmpty());
    });
    blocTest<TopRatedTvseriesCubit, TopRatedTvseriesState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer((realInvocation) async => Right(testTvseriesList));
        return topRatedTvseriesCubit;
      },
      act: (cubit) => cubit.fetchTopRatedSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedLoading(),
        TopRatedHasData(testTvseriesList),
      ],
    );
    blocTest<TopRatedTvseriesCubit, TopRatedTvseriesState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvseriesCubit;
      },
      act: (cubit) => cubit.fetchTopRatedSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedLoading(),
        TopRatedError('Server Failure'),
      ],
    );
  });
}