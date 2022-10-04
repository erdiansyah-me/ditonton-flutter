import 'package:core/common/exception.dart';
import 'package:tvseries/data/datasource/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test.mocks.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  late TvseriesLocalDataSourceImpl dataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSourceImpl = TvseriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save tvseries watchlist', () {
    test('should return success message when insert to database succeed',
      () async {
        when(mockDatabaseHelper.insertSeriesWatchlist(testTvseriesTable))
          .thenAnswer((_) async => 1);
        final result = await dataSourceImpl.insertSeriesWatchlist(testTvseriesTable);

        expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseRxception when insert to database failed',
      () async {
        when(mockDatabaseHelper.insertSeriesWatchlist(testTvseriesTable))
          .thenThrow(Exception());

        final call = dataSourceImpl.insertSeriesWatchlist(testTvseriesTable);

        expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove tvseries watchlist', () {
    test('should return success message when remove from database succeed',
      () async {
        when(mockDatabaseHelper.removeSeriesWatchlist(testTvseriesTable))
          .thenAnswer((_) async => 1);
        final result = await dataSourceImpl.removeSeriesWatchlist(testTvseriesTable);

        expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseRxception when remove from database failed',
      () async {
        when(mockDatabaseHelper.removeSeriesWatchlist(testTvseriesTable))
          .thenThrow(Exception());

        final call = dataSourceImpl.removeSeriesWatchlist(testTvseriesTable);

        expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tvseries detail by id', () {
    final tId = 1;
    test('should return TvseriesDetail when data found',
      () async {
        when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => testTvseriesMap);
        final result = await dataSourceImpl.getSeriesById(tId);

        expect(result, testTvseriesTable);
    });

    test('should return null when data is not found',
      () async {
        when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => null);

        final call = await dataSourceImpl.getSeriesById(tId);

        expect(call, null);
    });
  });

  group('get watchlist tvseries', () {
    test('should return list of TvseriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testTvseriesMap]);
      // act
      final result = await dataSourceImpl.getWatchlistSeries();
      // assert
      expect(result, [testTvseriesTable]);
    });
  });
}