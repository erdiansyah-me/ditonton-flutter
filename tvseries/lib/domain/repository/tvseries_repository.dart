import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';

abstract class TvseriesRepository {
  Future<Either<Failure, List<Tvseries>>> getOnTheAirSeries();
  Future<Either<Failure, List<Tvseries>>> getPopularSeries();
  Future<Either<Failure, List<Tvseries>>> getTopRatedSeries();
  Future<Either<Failure, TvseriesDetail>> getTvseriesDetail(int id);
  Future<Either<Failure, List<Tvseries>>> getRecommendationSeries(int id);
  Future<Either<Failure, List<Tvseries>>> searchSeries(String query);
  Future<Either<Failure, String>> saveSeriesWatchlist(TvseriesDetail tvseries);
  Future<Either<Failure, String>> removeSeriesWatchlist(TvseriesDetail tvseries);
  Future<bool> isAddedToSeriesWatchlist(int id);
  Future<Either<Failure, List<Tvseries>>> getWatchlistSeries();
}