import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTopRatedSeries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];
  test('should get list of top rated Tvseries from the repository', () async {
    when(mockTvseriesRepository.getTopRatedSeries()).thenAnswer((_) async => Right(tTvseries));

    final result = await usecase.execute();

    expect(result, Right(tTvseries));
  });
}