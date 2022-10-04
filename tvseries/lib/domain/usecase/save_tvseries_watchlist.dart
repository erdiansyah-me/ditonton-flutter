import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class SaveSeriesWatchlist {

  final TvseriesRepository repository;
  SaveSeriesWatchlist(this.repository);
  
  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.saveSeriesWatchlist(tvseries);
  }
}