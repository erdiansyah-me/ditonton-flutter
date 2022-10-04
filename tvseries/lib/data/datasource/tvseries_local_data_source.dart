import 'package:core/common/exception.dart';
import 'package:core/data/database/database_helper.dart';
import 'package:tvseries/data/model/tvseries_table.dart';

abstract class TvseriesLocalDataSource {
  Future<String> insertSeriesWatchlist(TvseriesTable series);
  Future<String> removeSeriesWatchlist(TvseriesTable series);
  Future<TvseriesTable?> getSeriesById(int id);
  Future<List<TvseriesTable>> getWatchlistSeries();
}

class TvseriesLocalDataSourceImpl implements TvseriesLocalDataSource {
  final DatabaseHelper databaseHelper;
  TvseriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvseriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if(result != null) {
      return TvseriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvseriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistSeries();
    return result.map((data) => TvseriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertSeriesWatchlist(TvseriesTable series) async {
    try {
      await databaseHelper.insertSeriesWatchlist(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeSeriesWatchlist(TvseriesTable series) async {
    try {
      await databaseHelper.removeSeriesWatchlist(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

}