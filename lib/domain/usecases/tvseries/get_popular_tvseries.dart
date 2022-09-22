import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/Tvseries.dart';
import '../../repositories/tvseries_repository.dart';

class GetPopularSeries {
  final TvseriesRepository repository;
  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getPopularSeries();
  }
}