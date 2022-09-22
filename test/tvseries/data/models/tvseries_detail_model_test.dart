import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvseriesDetaiResponse = TvseriesDetailResponse(
    backdropPath: backdropPath,
    firstAirDate: firstAirDate,
    genres: genres,
    homepage: homepage,
    id: id,
    inProduction: inProduction,
    languages: languages,
    lastAirDate: lastAirDate,
    name: name,
    numberOfEpisodes: numberOfEpisodes,
    numberOfSeasons: numberOfSeasons,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    status: status,
    tagline: tagline,
    type: type,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  final tTvseriesDetail = TvseriesDetail(
    backdropPath: backdropPath,
    firstAirDate: firstAirDate,
    genres: genres,
    homepage: homepage,
    id: id,
    inProduction: inProduction,
    languages: languages,
    lastAirDate: lastAirDate,
    name: name,
    numberOfEpisodes: numberOfEpisodes,
    numberOfSeasons: numberOfSeasons,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    status: status,
    tagline: tagline,
    type: type,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  test('should be a subclass of TvseriesDetail Entity', (){
    final result = tTvseriesDetaiResponse.toEntity();
    expect(result, tTvseriesDetail);
  });
}
