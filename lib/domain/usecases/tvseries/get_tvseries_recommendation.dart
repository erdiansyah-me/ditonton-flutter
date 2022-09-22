import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetSeriesRecommendation {
  final TvseriesRepository repository;
  GetSeriesRecommendation(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(id) {
    return repository.getRecommendationSeries(id);
  }
}