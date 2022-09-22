import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

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

  final tTvseriesResponse = TvseriesResponse(tvseriesList: <TvseriesModel>[tTvseriesModel]);

  group('from json', (){
    test('should return model from json', () {
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/on_the_air_tvseries.json'));

      final result = TvseriesResponse.fromJson(jsonMap);

      expect(result, tTvseriesResponse);
    });
  });

  group('to json', () {
    test('should return json map with data', () {
      final result = tTvseriesResponse.toJson();

      final expectedJsonMap = {
        
      };
      expect(result, expectedJsonMap);
    });
  });

}
