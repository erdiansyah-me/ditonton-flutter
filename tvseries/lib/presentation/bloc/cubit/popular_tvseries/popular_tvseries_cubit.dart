import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
part 'popular_tvseries_state.dart';

class PopularTvseriesCubit extends Cubit<PopularTvseriesState> {
  final GetPopularSeries _getPopularSeries;

  PopularTvseriesCubit(this._getPopularSeries) : super(PopularEmpty());

  Future<void> fetchPopularSeries() async {
    emit(PopularLoading());

    final result = await _getPopularSeries.execute();

    result.fold(
      (failure) {
        emit(PopularError(failure.message));
      },
      (data) {
        emit(PopularHasData(data));
      },
    );
  }
}
