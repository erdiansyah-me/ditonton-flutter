import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _movieSearch;

  MovieSearchBloc(this._movieSearch) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());

        final result = await _movieSearch.execute(query);

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
