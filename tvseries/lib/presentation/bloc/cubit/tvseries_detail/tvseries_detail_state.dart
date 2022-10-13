part of 'tvseries_detail_cubit.dart';

abstract class TvseriesDetailState extends Equatable {
  TvseriesDetailState();

  @override
  List<Object?> get props => [];
}

class DetailLoading extends TvseriesDetailState {}

class DetailEmpty extends TvseriesDetailState {}

class DetailError extends TvseriesDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailHasData extends TvseriesDetailState {
  final TvseriesDetail tvseriesDetail;
  final List<Tvseries> recommendationDetail;
  final bool isAddedtoSeriesWatchlist;

  DetailHasData(
    this.tvseriesDetail,
    this.recommendationDetail,
    this.isAddedtoSeriesWatchlist,
  );

  @override
  List<Object?> get props => [
        tvseriesDetail,
        recommendationDetail,
        isAddedtoSeriesWatchlist,
      ];

  @override
  DetailHasData copy({
    TvseriesDetail? tvseriesDetail,
    List<Tvseries>? recommendationDetail,
    bool? isAddedtoSeriesWatchlist,
  }) {
    return DetailHasData(
      tvseriesDetail ?? this.tvseriesDetail,
      recommendationDetail ?? this.recommendationDetail,
      isAddedtoSeriesWatchlist ?? this.isAddedtoSeriesWatchlist,
    );
  }
}
