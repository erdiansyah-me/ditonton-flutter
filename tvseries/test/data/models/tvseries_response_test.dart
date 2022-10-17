import 'dart:convert';

import 'package:tvseries/data/model/tvseries_model.dart';
import 'package:tvseries/data/model/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvseriesModel = TvseriesModel(
    backdropPath: '/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg',
    firstAirDate: '2015-05-27',
    genreIds: [80, 18],
    id: 62560,
    name: 'Mr. Robot',
    originalName: 'Mr. Robot',
    overview: 'A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.',
    popularity: 37.882356,
    posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
    voteAverage: 7.5,
    voteCount: 287,
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
        "results": [
        {
            "poster_path": "/esN3gWb1P091xExLddD2nh4zmi3.jpg",
            "popularity": 37.882356,
            "id": 62560,
            "backdrop_path": "/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg",
            "vote_average": 7.5,
            "overview": "A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.",
            "first_air_date": "2015-05-27",
            "genre_ids": [
                80,
                18
            ],
            "vote_count": 287,
            "name": "Mr. Robot",
            "original_name": "Mr. Robot"
          }
      ],
      };
      expect(result, expectedJsonMap);
    });
  });

}
