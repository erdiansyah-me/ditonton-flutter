part of 'tvseries_list_cubit.dart';

abstract class TvseriesListState extends Equatable {
  const TvseriesListState();

  @override
  List<Object?> get props => [];
}

class ListEmpty extends TvseriesListState {}

class ListLoading extends TvseriesListState {}

class ListError extends TvseriesListState {
  final String message;

  const ListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ListHasData extends TvseriesListState {
  final List<Tvseries> onTheAirSeriesResult;
  final List<Tvseries> popularSeriesResult;
  final List<Tvseries> topRatedSeriesResult;

  const ListHasData({required this.onTheAirSeriesResult, required this.popularSeriesResult, required this.topRatedSeriesResult});

  @override
  List<Object?> get props => [
        onTheAirSeriesResult,
        popularSeriesResult,
        topRatedSeriesResult,
      ];
}