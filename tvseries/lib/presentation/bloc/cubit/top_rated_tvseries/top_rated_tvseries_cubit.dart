import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTvseriesCubit extends Cubit<TopRatedTvseriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedTvseriesCubit(this._getTopRatedSeries) : super(TopRatedEmpty());

  Future<void> fetchTopRatedSeries() async {
    emit(TopRatedLoading());

    final result = await _getTopRatedSeries.execute();

    result.fold(
      (failure) {
        emit(TopRatedError(failure.message));
      },
      (data) {
        emit(TopRatedHasData(data));
      },
    );
  }
}
