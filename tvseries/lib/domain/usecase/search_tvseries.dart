import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/repository/tvseries_repository.dart';

class SearchSeries {
  final TvseriesRepository repository;
  SearchSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(String query) {
    return repository.searchSeries(query);
  }
}