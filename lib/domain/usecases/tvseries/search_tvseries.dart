import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SearchSeries {
  final TvseriesRepository repository;
  SearchSeries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(String query) {
    return repository.searchSeries(query);
  }
}