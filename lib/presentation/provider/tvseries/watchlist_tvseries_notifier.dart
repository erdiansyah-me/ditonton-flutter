import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvseriesNotifier extends ChangeNotifier {
  var _seriesWatchlist = <Tvseries>[];
  List<Tvseries> get seriesWatchlist => _seriesWatchlist;

  var _seriesWatchlistState = RequestState.Empty;
  RequestState get seriesWatchlistState => _seriesWatchlistState;

  String _message = '';
  String get message => _message;

  final GetWatchlistSeries getWatchlistSeries;

  WatchlistTvseriesNotifier({required this.getWatchlistSeries});

  Future<void> fetchWatchlistSeries() async {
    _seriesWatchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _seriesWatchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistSeries) {
        _seriesWatchlistState = RequestState.Loaded;
        _seriesWatchlist = watchlistSeries;
        notifyListeners();
      },
    );
  }
}
