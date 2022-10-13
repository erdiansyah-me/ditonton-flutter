import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
part 'popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieCubit(this._getPopularMovies) : super(PopularEmpty());

  Future<void> fetchPopularMovie() async {
    emit(PopularLoading());

    final result = await _getPopularMovies.execute();

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
