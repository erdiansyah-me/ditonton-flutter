import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_recommendation.dart';
import 'package:tvseries/domain/usecase/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecase/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecase/save_tvseries_watchlist.dart';
import 'package:flutter/cupertino.dart';

class TvseriesDetailNotifier extends ChangeNotifier {
  static const seriesWatchlistAddSuccessMessage =
      'Added to Watchlist';
  static const seriesWatchlistRemoveSuccessMessage =
      'Removed from Watchlist';

  final GetTvseriesDetail getTvseriesDetail;
  final GetSeriesRecommendation getSeriesRecommendation;
  final GetSeriesWatchListStatus getSeriesWatchListStatus;
  final SaveSeriesWatchlist saveSeriesWatchlist;
  final RemoveSeriesWatchlist removeSeriesWatchlist;

  TvseriesDetailNotifier({
    required this.getTvseriesDetail,
    required this.getSeriesRecommendation,
    required this.getSeriesWatchListStatus,
    required this.saveSeriesWatchlist,
    required this.removeSeriesWatchlist,
  });

  late TvseriesDetail _series;
  TvseriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  List<Tvseries> _seriesRecommendation = [];
  List<Tvseries> get seriesRecommendation => _seriesRecommendation;

  RequestState _seriesRecommendationState = RequestState.Empty;
  RequestState get seriesRecommendationState => _seriesRecommendationState;

  String _message = '';
  String get message => _message;

  String _seriesWatchlistMessage = '';
  String get seriesWatchlistMessage => _seriesWatchlistMessage;

  bool _isAddedtoSeriesWatchlist = false;
  bool get isAddedtoSeriesWatchlist => _isAddedtoSeriesWatchlist;

  Future<void> fetchTvseriesDetail(int idSeries) async {
    _seriesState = RequestState.Loading;
    notifyListeners();

    final resultDetail = await getTvseriesDetail.execute(idSeries);
    final resultRecommendation =
        await getSeriesRecommendation.execute(idSeries);

    resultDetail.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesDetail) {
        _seriesRecommendationState = RequestState.Loading;
        _series = seriesDetail;
        notifyListeners();
        resultRecommendation.fold(
          (failure) {
            _seriesRecommendationState = RequestState.Error;
            _message = failure.message;
          },
          (recommnedationDetail) {
            _seriesRecommendationState = RequestState.Loaded;
            _seriesRecommendation = recommnedationDetail;
          },
        );
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addSeriesWatchlist(TvseriesDetail seriesDetail) async {
    final result = await saveSeriesWatchlist.execute(seriesDetail);

    await result.fold(
      (failure) async {
        _seriesWatchlistMessage = failure.message;
      },
      (success) async {
        _seriesWatchlistMessage = success;
      },
    );

    await loadSeriesWatchlistStatus(seriesDetail.id);
  }

  Future<void> removeFromSeriesWatchlist(TvseriesDetail seriesDetail) async {
    final result = await removeSeriesWatchlist.execute(seriesDetail);

    await result.fold(
      (failure) async {
        _seriesWatchlistMessage = failure.message;
      },
      (success) async {
        _seriesWatchlistMessage = success;
      },
    );

    await loadSeriesWatchlistStatus(seriesDetail.id);
  }

  
  Future<void> loadSeriesWatchlistStatus(int idSeries) async {
    final result = await getSeriesWatchListStatus.execute(idSeries);
    _isAddedtoSeriesWatchlist = result;
    notifyListeners();
  }
}
