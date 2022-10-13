part of 'watchlist_movie_cubit.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}
class WatchlistEmpty extends WatchlistMovieState {}
class WatchlistLoading extends WatchlistMovieState {}
class WatchlistError extends WatchlistMovieState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
class WatchlistHasData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistHasData(this.result);

  @override
  List<Object?> get props => [result];
}