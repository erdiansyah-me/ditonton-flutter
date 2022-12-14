import 'dart:io';
import 'package:core/common/exception.dart';
import 'package:tvseries/data/datasource/tvseries_remote_data_source.dart';
import 'package:tvseries/data/model/tvseries_detail_model.dart';
import 'package:tvseries/data/model/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import '../../helpers/tvseries_test.mocks.dart';
import '../../json_reader.dart';
import 'package:http/http.dart' as http;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvseriesRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TvseriesRemoteDataSourceImpl(client: mockHttpClient);
    
  });
  

  group('get On The Air Tvseries', () {
    final tTvseriesList = TvseriesResponse.fromJson(
      json.decode(readJson('dummy_data/on_the_air_tvseries.json'))
    ).tvseriesList;
    

    test('should return list of Tvseries Model when response code succeed', ()async{
      
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
      .thenAnswer((_) async => 
          http.Response(readJson('dummy_data/on_the_air_tvseries.json'), 200));

      final result = await dataSourceImpl.getOnTheAirSeries();

      expect(result, equals(tTvseriesList));
    });

    test(
      'should throw ServerException when response code failed', 
      () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSourceImpl.getOnTheAirSeries();

      expect(() => call , throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvseries', () {
    final tTvseriesList = TvseriesResponse.fromJson(
      json.decode(readJson('dummy_data/popular_tvseries.json'))
    ).tvseriesList;

    test('should return list of Tvseries Model when response code succeed', ()async{
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
      .thenAnswer((_) async => 
          http.Response(readJson('dummy_data/popular_tvseries.json'), 200,
          headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }
          ));

      final result = await dataSourceImpl.getPopularSeries();

      expect(result, equals(tTvseriesList));
    });

    test('should throw ServerException when response code failed', ()async{
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
      .thenAnswer((_) async => 
          http.Response('Not Found', 404));

      final call = dataSourceImpl.getPopularSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvseries', () {
    final tTvseriesList = TvseriesResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated_tvseries.json'))
    ).tvseriesList;

    test('should return list of Tvseries Model when response code succeed', ()async{
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
      .thenAnswer((_) async => 
          http.Response(readJson('dummy_data/top_rated_tvseries.json'), 200));

      final result = await dataSourceImpl.getTopRatedSeries();

      expect(result, equals(tTvseriesList));
    });

    test('should throw ServerException when response code failed', ()async{
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
      .thenAnswer((_) async => 
          http.Response('Not Found', 404));

      final call = dataSourceImpl.getTopRatedSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tvseries detail', () {
    final tId = 1399;
    final tTvseriesDetail = TvseriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_detail.json')));

    test('should return TvseriesDetail when the response code succeed', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries_detail.json'), 200));
      // act
      final result = await dataSourceImpl.getTvseriesDetail(tId);
      // assert
      expect(result, equals(tTvseriesDetail));
    });

    test('should throw Server Exception when the response code failed',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTvseriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get tvseries recommendations', () {
    final tTvseriesList = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/recommendation_attack_on_titan_tvseries.json')))
        .tvseriesList;
    final tId = 1429;

    test('should return list of tvseries Model when the response code is succeed',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/recommendation_attack_on_titan_tvseries.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }
              ));
      // act
      final result = await dataSourceImpl.getRecommendationSeries(tId);
      // assert
      expect(result, equals(tTvseriesList));
    });

    test('should throw Server Exception when the response code is failed',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getRecommendationSeries(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tvseries search', () {
    final tQuery = 'attack on titan';
    final tTvseriesList = TvseriesResponse.fromJson(
        json.decode(readJson('dummy_data/search_attack_on_titan_tvseries.json'))).tvseriesList;

    test('should return Tvseries model when the response code succeed', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search_attack_on_titan_tvseries.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }
            ),
          );
      // act
      final result = await dataSourceImpl.searchSeries(tQuery);
      // assert
      expect(result, equals(tTvseriesList));
    });

    test('should throw Server Exception when the response code failed',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}