import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_watchlist_tvseries.dart';
part 'watchlist_tvseries_state.dart';

class WatchlistTvseriesCubit extends Cubit<WatchlistTvseriesState> {
  final GetWatchlistSeries _getWatchlistSeries;

  WatchlistTvseriesCubit(this._getWatchlistSeries) : super(WatchlistEmpty());

  Future<void> fetchWatchlistSeries() async {
    emit(WatchlistLoading());

    final result = await _getWatchlistSeries.execute();

    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (data) {
        emit(WatchlistHasData(data));
      },
    );
  }
}
