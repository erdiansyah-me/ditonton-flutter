import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class GetWatchlistSeries {
  final TvseriesRepository repository;
  GetWatchlistSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getWatchlistSeries();
  }
}