import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:core/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository repository;

  GetWatchlistMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getWatchlistMovies();
  }
}
