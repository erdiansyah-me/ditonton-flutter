import 'package:tvseries/data/model/tvseries_model.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvseriesModel = TvseriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1,2,3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvseries = Tvseries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1,2,3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of tvseries entity', (){
    final result = tTvseriesModel.toEntity();

    expect(result, tTvseries);
  });
}
