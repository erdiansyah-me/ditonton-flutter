import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieCubit(this._getTopRatedMovies) : super(TopRatedEmpty());

  Future<void> fetchTopRatedMovie() async {
    emit(TopRatedLoading());

    final result = await _getTopRatedMovies.execute();

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