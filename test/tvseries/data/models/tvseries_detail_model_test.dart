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

  test('should return json map with data', () {
    final result = tTvseriesDetaiResponse.toJson();

    final expectedJsonMap = {
      "backdrop_path": "backdropPath",
      "first_air_date": "2021-01-01",
      "genres": [
        {
          "id": 1,
          "name": "name"
        },
      ],
      "homepage": "homepage",
      "id": 1,
      "in_production": false,
      "languages": [
        "En"
      ],
      "last_air_date": "2021-01-01",
      "name": "name",
      "number_of_episodes": 1,
      "number_of_seasons": 1,
      "original_name": "originalName",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "status": "status",
      "tagline": "tagline",
      "type": "type",
      "vote_average": 1,
      "vote_count": 1
    };
    expect(result, expectedJsonMap);
  });
  });
}
