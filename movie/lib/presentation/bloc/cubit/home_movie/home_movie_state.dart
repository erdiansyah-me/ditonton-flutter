part of 'home_movie_cubit.dart';

abstract class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object?> get props => [];
}

class HomeEmpty extends HomeMovieState {}
class HomeLoading extends HomeMovieState {}
class HomeError extends HomeMovieState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeHasData extends HomeMovieState {
  final List<Movie> nowPlayingMovieResult;
  final List<Movie> popularMovieResult;
  final List<Movie> topRatedMovieResult;

  const HomeHasData({
    required this.nowPlayingMovieResult,
    required this.popularMovieResult,
    required this.topRatedMovieResult,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    nowPlayingMovieResult,
    popularMovieResult,
    topRatedMovieResult,
  ];
}