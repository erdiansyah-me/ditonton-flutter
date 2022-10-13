part of 'top_rated_tvseries_cubit.dart';

class TopRatedTvseriesState extends Equatable {

  const TopRatedTvseriesState();

  @override
  List<Object?> get props => [];
}

class TopRatedEmpty extends TopRatedTvseriesState {}
class TopRatedLoading extends TopRatedTvseriesState {}
class TopRatedError extends TopRatedTvseriesState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
class TopRatedHasData extends TopRatedTvseriesState {
  final List<Tvseries> result;

  TopRatedHasData(this.result);

  @override
  List<Object?> get props => [result];
}
