import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  static const movieWatchlistAddSuccessMessage = 'Added to Watchlist';
  static const movieWatchlistRemoveSuccessMessage = 'Removed to Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailCubit(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(DetailEmpty());

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    emit(DetailLoading());

    final detailResult = await _getMovieDetail.execute(id);
    final recommendationResult = await _getMovieRecommendations.execute(id);
    final isAddedToWatchlist = await _getWatchListStatus.execute(id);

    detailResult.fold(
      (failure) => emit(DetailError(failure.message)),
      (data) {
        recommendationResult.fold(
          (failure) => emit(DetailError(failure.message)),
          (recommendation) {
            emit(
              DetailHasData(
                data,
                recommendation,
                isAddedToWatchlist,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> addMovieWatchlist(MovieDetail movie) async {
    final result = await _saveWatchlist.execute(movie);

    result.fold(
      (failure) => _message = failure.message,
      (success) async {
        _message = success;
        final isAddedToWatchlist = await _getWatchListStatus.execute(movie.id);

        final isAdded = (state as DetailHasData).copy(isAddedToWatchlist: isAddedToWatchlist);
        emit(isAdded);
      },
    );
  }

  Future<void> removeMovieWatchlist(MovieDetail movie) async {
    final result = await _removeWatchlist.execute(movie);

    result.fold(
      (failure) => _message = failure.message,
      (success) async {
        _message = success;
        final isAddedToWatchlist = await _getWatchListStatus.execute(movie.id);

        final isAdded = (state as DetailHasData).copy(isAddedToWatchlist: isAddedToWatchlist);
        emit(isAdded);
      },
    );
  }
}
