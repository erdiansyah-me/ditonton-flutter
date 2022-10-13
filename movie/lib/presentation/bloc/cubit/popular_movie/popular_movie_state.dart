part of 'popular_movie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object?> get props => [];
}
class PopularEmpty extends PopularMovieState {}
class PopularLoading extends PopularMovieState {}
class PopularError extends PopularMovieState {
  final String message;

  PopularError(this.message);

  @override
  List<Object?> get props => [message];
}
class PopularHasData extends PopularMovieState {
  final List<Movie> result;

  PopularHasData(this.result);

  @override
  List<Object?> get props => [result];
}