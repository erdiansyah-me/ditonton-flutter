import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:flutter/cupertino.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvseries> _series = [];
  List<Tvseries> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      }, 
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      });
  }
}