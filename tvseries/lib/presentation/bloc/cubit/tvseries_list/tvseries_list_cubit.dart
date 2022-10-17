import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/get_on_the_air_tvseries.dart';
import 'package:tvseries/domain/usecase/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecase/get_top_rated_tvseries.dart';
part 'tvseries_list_state.dart';

class TvseriesListCubit extends Cubit<TvseriesListState> {
  final GetOnTheAirSeries _getOnTheAirSeries;
  final GetPopularSeries _getPopularSeries;
  final GetTopRatedSeries _getTopRatedSeries;

  TvseriesListCubit(
    this._getOnTheAirSeries,
    this._getPopularSeries,
    this._getTopRatedSeries,
  ) : super(ListEmpty());

  Future<void> fetchListSeries() async {
    emit(ListLoading());

    final onTheAirResult = await _getOnTheAirSeries.execute();
    final popularResult = await _getPopularSeries.execute();
    final topRatedResult = await _getTopRatedSeries.execute();

    final result = [onTheAirResult, popularResult, topRatedResult];
    final listData = result
        .map<List<Tvseries>>(
          (resultData) => resultData.fold(
            (failure) => [],
            (data) => data,
          ),
        )
        .toList();
    emit(stateList(listData));
  }

  TvseriesListState stateList(List<List<Tvseries>> data) {
    if (data.isEmpty || data.length < 3 || data.where((element) => element.isNotEmpty).isEmpty) {
      return ListError('Failed Load Data');
    }
    return ListHasData(
      onTheAirSeriesResult: data.elementAt(0),
      popularSeriesResult: data.elementAt(1),
      topRatedSeriesResult: data.elementAt(2),
    );
  }
}
