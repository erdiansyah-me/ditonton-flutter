part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  MovieDetailState();

  @override
  List<Object?> get props => [];
}

class DetailLoading extends MovieDetailState {}

class DetailEmpty extends MovieDetailState {}

class DetailError extends MovieDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> recommendationDetail;
  final bool isAddedToWatchlist;

  DetailHasData(
    this.movieDetail,
    this.recommendationDetail,
    this.isAddedToWatchlist,
  );

  @override
  List<Object?> get props => [
        movieDetail,
        recommendationDetail,
        isAddedToWatchlist,
      ];

  @override
  DetailHasData copy({
    MovieDetail? movieDetail,
    List<Movie>? recommendationDetail,
    bool? isAddedToWatchlist,
  }) {
    return DetailHasData(
      movieDetail ?? this.movieDetail,
      recommendationDetail ?? this.recommendationDetail,
      isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }
}
