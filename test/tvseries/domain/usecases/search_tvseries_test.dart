import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SearchSeries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];
  final tQuery = 'attack on titan';

  test('should get list of search Tvseries from the repository', () async {
    when(mockTvseriesRepository.searchSeries(tQuery)).thenAnswer((_) async => Right(tTvseries));

    final result = await usecase.execute(tQuery);

    expect(result, Right(tTvseries));
  });
}