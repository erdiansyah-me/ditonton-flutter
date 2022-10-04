import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetPopularSeries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];
  test('should get list of Popular Tvseries from the repository', () async {
    when(mockTvseriesRepository.getPopularSeries()).thenAnswer((_) async => Right(tTvseries));

    final result = await usecase.execute();

    expect(result, Right(tTvseries));
  });
}