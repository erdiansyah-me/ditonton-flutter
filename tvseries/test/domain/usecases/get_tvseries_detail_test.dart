import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecase/get_tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late GetTvseriesDetail usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp((){
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTvseriesDetail(mockTvseriesRepository);
  });
  final tId = 1;
  test('should get TvseriesDetail from the repository', () async {
    when(mockTvseriesRepository.getTvseriesDetail(tId)).thenAnswer((_) async => Right(testTvseriesDetail));

    final result = await usecase.execute(tId);

    expect(result, Right(testTvseriesDetail));
  });
}