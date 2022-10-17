import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/popular_tvseries/popular_tvseries_cubit.dart';

import '../../../dummy_data/tvseries_dummy_objects.dart';
import 'popular_tvseries_cubit_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularTvseriesCubit popularTvseriesCubit;
  late MockGetPopularSeries mockGetPopularTvseries;

  setUp(() {
    mockGetPopularTvseries = MockGetPopularSeries();
    popularTvseriesCubit =  PopularTvseriesCubit(mockGetPopularTvseries);
  });

  group('popular Tvseries cubit', () {
    test('initial state empty', () {
      expect(popularTvseriesCubit.state, PopularEmpty());
    });
    blocTest<PopularTvseriesCubit, PopularTvseriesState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetPopularTvseries.execute()).thenAnswer((realInvocation) async => Right(testTvseriesList));
        return popularTvseriesCubit;
      },
      act: (cubit) => cubit.fetchPopularSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularLoading(),
        PopularHasData(testTvseriesList),
      ],
    );
    blocTest<PopularTvseriesCubit, PopularTvseriesState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetPopularTvseries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvseriesCubit;
      },
      act: (cubit) => cubit.fetchPopularSeries(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularLoading(),
        PopularError('Server Failure'),
      ],
    );
  });
}