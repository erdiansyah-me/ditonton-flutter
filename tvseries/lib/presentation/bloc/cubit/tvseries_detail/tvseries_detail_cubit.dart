import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecase/get_tvseries_recommendation.dart';
import 'package:tvseries/domain/usecase/get_tvseries_watchlist_status.dart';
import 'package:tvseries/domain/usecase/remove_tvseries_watchlist.dart';
import 'package:tvseries/domain/usecase/save_tvseries_watchlist.dart';

part 'tvseries_detail_state.dart';

class TvseriesDetailCubit extends Cubit<TvseriesDetailState> {
  static const seriesWatchlistAddSuccessMessage = 'Added to Watchlist';
  static const seriesWatchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvseriesDetail _getTvseriesDetail;
  final GetSeriesWatchListStatus _getSeriesWatchListStatus;
  final GetSeriesRecommendation _getSeriesRecommendation;
  final SaveSeriesWatchlist _saveSeriesWatchlist;
  final RemoveSeriesWatchlist _removeSeriesWatchlist;

  TvseriesDetailCubit(
      this._getTvseriesDetail,
      this._getSeriesWatchListStatus,
      this._getSeriesRecommendation,
      this._saveSeriesWatchlist,
      this._removeSeriesWatchlist)
      : super(DetailEmpty());

  String _message = '';
  String get message => _message;

  Future<void> fetchTvseriesDetail(int id) async {
    emit(DetailLoading());

    final detailResult = await _getTvseriesDetail.execute(id);
    final recommendationResult = await _getSeriesRecommendation.execute(id);
    final isAddedtoSeriesWatchlist =
        await _getSeriesWatchListStatus.execute(id);

    detailResult.fold(
      (failure) => emit(DetailError(failure.message)),
      (data) {
        recommendationResult.fold(
          (failure) => emit(DetailError(failure.message)),
          (recommendation) {
            emit(
              DetailHasData(
                data,
                recommendation,
                isAddedtoSeriesWatchlist,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> addSeriesWatchlist(TvseriesDetail tvseries) async {
    final result = await _saveSeriesWatchlist.execute(tvseries);

    result.fold(
      (failure) => _message = failure.message,
      (success) async {
        _message = success;
        final isAddedtoSeriesWatchlist = await _getSeriesWatchListStatus.execute(tvseries.id);

        final isAdded = (state as DetailHasData).copy(isAddedtoSeriesWatchlist: isAddedtoSeriesWatchlist);
        emit(isAdded);
      },
    );
  }

  Future<void> removeSeriesWatchlist(TvseriesDetail tvseries) async {
    final result = await _removeSeriesWatchlist.execute(tvseries);

    result.fold(
      (failure) => _message = failure.message,
      (success) async {
        _message = success;
        final isAddedtoSeriesWatchlist = await _getSeriesWatchListStatus.execute(tvseries.id);

        final isAdded = (state as DetailHasData).copy(isAddedtoSeriesWatchlist: isAddedtoSeriesWatchlist);
        emit(isAdded);
      },
    );
  }
}
