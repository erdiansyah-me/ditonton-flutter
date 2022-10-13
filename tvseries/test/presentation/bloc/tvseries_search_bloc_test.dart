import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecase/search_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_search_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late TvseriesSearchBloc tvseriesSearchBloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    tvseriesSearchBloc = TvseriesSearchBloc(mockSearchSeries);
  });

  const tQuery = 'spiderman';

  group('movie search bloc', () {
    test('initial state is Empty', () {
      expect(tvseriesSearchBloc.state, SearchEmpty());
    });

    blocTest<TvseriesSearchBloc, TvseriesSearchState>(
      'emits [Loading, HasData] when get data succeed.',
      build: () {
        when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testTvseriesList));
        return tvseriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(testTvseriesList),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );

    blocTest<TvseriesSearchBloc, TvseriesSearchState>(
      'emits [Loading, Error] when get data succeed.',
      build: () {
        when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvseriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );
  });
}