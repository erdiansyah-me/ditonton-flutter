import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'home_movie_state.dart';

class HomeMovieCubit extends Cubit<HomeMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  HomeMovieCubit(
    this._getNowPlayingMovies,
    this._getPopularMovies,
    this._getTopRatedMovies,
  ) : super(HomeEmpty());

  Future<void> fetchHomeMovieList() async {
    emit(HomeLoading());

    final nowPlayingResult = await _getNowPlayingMovies.execute();
    final popularResult = await _getPopularMovies.execute();
    final topRatedResult = await _getTopRatedMovies.execute();

    final result = [nowPlayingResult, popularResult, topRatedResult];

    final listData = result
        .map<List<Movie>>(
          (resultData) => resultData.fold(
            (failure) => [],
            (data) => data,
          ),
        )
        .toList();
    emit(stateList(listData));
  }

  HomeMovieState stateList(List<List<Movie>> data) {
      if (data.isEmpty || data.length < 3 || data.where((element) => element.isNotEmpty).isEmpty) {
        return const HomeError('Failed to Load Data');
      }
      return HomeHasData(
        nowPlayingMovieResult: data.elementAt(0),
        popularMovieResult: data.elementAt(1),
        topRatedMovieResult: data.elementAt(2),
      );
    }
}
