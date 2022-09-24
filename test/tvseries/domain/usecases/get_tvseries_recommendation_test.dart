import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendation usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetSeriesRecommendation(mockTvseriesRepository);
  });
  final tId = 1;
  final tTvseries = <Tvseries>[];
  test('should get list of recommendation Tvseries from the repository', () async {
    when(mockTvseriesRepository.getRecommendationSeries(tId)).thenAnswer((_) async => Right(tTvseries));

    final result = await usecase.execute(tId);

    expect(result, Right(tTvseries));
  });
}