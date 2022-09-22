import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

import '../../entities/Tvseries_detail.dart';

class RemoveSeriesWatchlist {
  final TvseriesRepository repository;
  RemoveSeriesWatchlist(this.repository);
  
  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.removeSeriesWatchlist(tvseries);
  }
}