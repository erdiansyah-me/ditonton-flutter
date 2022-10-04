import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/search_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvseriesSearchNotifier extends ChangeNotifier {
  final SearchSeries searchSeries;

  TvseriesSearchNotifier({required this.searchSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvseries> _searchSeriesResult = [];
  List<Tvseries> get searchSeriesResult => _searchSeriesResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvseriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchSeries.execute(query);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (searchSeriesData) {
        _searchSeriesResult = searchSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
