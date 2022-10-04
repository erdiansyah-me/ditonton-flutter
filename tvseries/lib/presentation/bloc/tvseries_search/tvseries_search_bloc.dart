import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/usecase/search_tvseries.dart';
part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

class TvseriesSearchBloc
    extends Bloc<TvseriesSearchEvent, TvseriesSearchState> {
  final SearchSeries _searchSeries;

  TvseriesSearchBloc(this._searchSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());

        final result = await _searchSeries.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasData(data));
          },
        );
      }, transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).flatMap(mapper)
    );
  }
}
