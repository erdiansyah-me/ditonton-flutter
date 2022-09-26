import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvseriesDetaiResponse = TvseriesDetailResponse(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime(2021),
    genres: [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: ['En'],
    lastAirDate: DateTime(2021),
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvseriesDetail = TvseriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime(2021),
    genres:  [Genre(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: ['En'],
    lastAirDate: DateTime(2021),
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  group('tvseries detail model', () {
    test('should be a subclass of TvseriesDetail Entity', (){
      final result = tTvseriesDetaiResponse.toEntity();
      expect(result, tTvseriesDetail);
    });
  });
}
