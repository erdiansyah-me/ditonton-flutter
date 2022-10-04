import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class GetTvseriesDetail {
  final TvseriesRepository repository;
  GetTvseriesDetail(this.repository);

  Future<Either<Failure, TvseriesDetail>> execute(id) {
    return repository.getTvseriesDetail(id);
  }
}