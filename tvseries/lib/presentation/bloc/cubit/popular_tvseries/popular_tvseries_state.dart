part of 'popular_tvseries_cubit.dart';

class PopularTvseriesState extends Equatable {

  const PopularTvseriesState();

  @override
  List<Object?> get props => [];
}

class PopularEmpty extends PopularTvseriesState {}
class PopularLoading extends PopularTvseriesState {}
class PopularError extends PopularTvseriesState {
  final String message;

  PopularError(this.message);

  @override
  List<Object?> get props => [message];
}
class PopularHasData extends PopularTvseriesState {
  final List<Tvseries> result;

  PopularHasData(this.result);

  @override
  List<Object?> get props => [result];
}
