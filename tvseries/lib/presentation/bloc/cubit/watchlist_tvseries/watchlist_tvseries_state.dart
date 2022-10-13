part of 'watchlist_tvseries_cubit.dart';

class WatchlistTvseriesState extends Equatable {

  const WatchlistTvseriesState();

  @override
  List<Object?> get props => [];
}

class WatchlistEmpty extends WatchlistTvseriesState {}
class WatchlistLoading extends WatchlistTvseriesState {}
class WatchlistError extends WatchlistTvseriesState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
class WatchlistHasData extends WatchlistTvseriesState {
  final List<Tvseries> result;

  WatchlistHasData(this.result);

  @override
  List<Object?> get props => [result];
}
