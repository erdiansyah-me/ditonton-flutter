import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

import 'package:tvseries/domain/entities/Tvseries_detail.dart';

class RemoveSeriesWatchlist {
  final TvseriesRepository repository;
  RemoveSeriesWatchlist(this.repository);
  
  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.removeSeriesWatchlist(tvseries);
  }
}