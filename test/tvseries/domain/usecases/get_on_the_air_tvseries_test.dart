import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirSeries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetOnTheAirSeries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];
  test('should get list of On The Air Tvseries from the repository', () async {
    when(mockTvseriesRepository.getOnTheAirSeries()).thenAnswer((_) async => Right(tTvseries));

    final result = await usecase.execute();

    expect(result, Right(tTvseries));
  });
}