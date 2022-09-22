import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../entities/Tvseries.dart';
import '../../repositories/tvseries_repository.dart';

class GetTopRatedSeries {
  final TvseriesRepository repository;
  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getTopRatedSeries();
  }
}