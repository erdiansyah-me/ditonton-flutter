import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';

import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class GetOnTheAirSeries {
  final TvseriesRepository repository;
  GetOnTheAirSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getOnTheAirSeries();
  }
}