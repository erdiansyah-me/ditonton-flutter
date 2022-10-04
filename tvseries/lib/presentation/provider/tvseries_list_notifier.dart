import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_on_the_air_tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvseriesListNotifier extends ChangeNotifier {
  var _onTheAirSeries = <Tvseries>[];
  List<Tvseries> get onTheAirSeries => _onTheAirSeries;

  var _popularSeries = <Tvseries>[];
  List<Tvseries> get popularSeries => _popularSeries;

  var _topRatedSeries = <Tvseries>[];
  List<Tvseries> get topRatedSeries => _topRatedSeries;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  final GetOnTheAirSeries getOnTheAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  TvseriesListNotifier(
      {required this.getOnTheAirSeries,
      required this.getPopularSeries,
      required this.getTopRatedSeries});

  Future<void> fetchOnTheAirSeries() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirSeries.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (onTheAirSeries) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirSeries = onTheAirSeries;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (popularSeries) {
        _popularState = RequestState.Loaded;
        _popularSeries = popularSeries;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (topRatedSeries) {
        _topRatedState = RequestState.Loaded;
        _topRatedSeries = topRatedSeries;
        notifyListeners();
      },
    );
  }
}
