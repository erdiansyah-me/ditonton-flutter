import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvseriesRepository,
  TvseriesRemoteDataSource,
  TvseriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}