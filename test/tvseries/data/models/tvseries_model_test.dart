import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvseriesModel = TvseriesModel(
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    firstAirDate: firstAirDate,
    name: name,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  final tTvseries = Tvseries(
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    firstAirDate: firstAirDate,
    name: name,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  test('should be a subclass of tvseries entity', (){
    final result = tTvseriesModel.toEntity();

    expect(result, tTvseries);
  });
}
