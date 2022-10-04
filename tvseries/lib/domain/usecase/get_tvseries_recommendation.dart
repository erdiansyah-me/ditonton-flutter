import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class GetSeriesRecommendation {
  final TvseriesRepository repository;
  GetSeriesRecommendation(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(id) {
    return repository.getRecommendationSeries(id);
  }
}