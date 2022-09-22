import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetSeriesWatchListStatus {
  final TvseriesRepository repository;

  GetSeriesWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToSeriesWatchlist(id);
  }
}