import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvseriesDetail {
  final TvseriesRepository repository;
  GetTvseriesDetail(this.repository);

  Future<Either<Failure, TvseriesDetail>> execute(id) {
    return repository.getTvseriesDetail(id);
  }
}