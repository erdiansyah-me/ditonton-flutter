import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SaveSeriesWatchlist {

  final TvseriesRepository repository;
  SaveSeriesWatchlist(this.repository);
  
  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.saveSeriesWatchlist(tvseries);
  }
}