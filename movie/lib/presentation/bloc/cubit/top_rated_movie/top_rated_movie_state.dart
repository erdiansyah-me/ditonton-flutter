part of 'top_rated_movie_cubit.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object?> get props => [];
}
class TopRatedEmpty extends TopRatedMovieState {}
class TopRatedLoading extends TopRatedMovieState {}
class TopRatedError extends TopRatedMovieState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
class TopRatedHasData extends TopRatedMovieState {
  final List<Movie> result;

  TopRatedHasData(this.result);

  @override
  List<Object?> get props => [result];
}