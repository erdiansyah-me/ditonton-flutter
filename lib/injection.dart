import 'package:tvseries/tvseries.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => HomeMovieCubit(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () =>PopularMovieCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieCubit(
      locator(),
    ),
  );

  //bloc tvseries
  locator.registerFactory(
    () => TvseriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvseriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvseriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvseriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvseriesListCubit(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvseriesDetailCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //use case tvseries
  locator.registerLazySingleton(() => GetOnTheAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetTvseriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvseriesRepository>(
    () => TvseriesRepositoryImpl(
      seriesRemoteDataSource: locator(),
      seriesLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // tvseries datasource
  locator.registerLazySingleton<TvseriesRemoteDataSource>(
      () => TvseriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvseriesLocalDataSource>(
      () => TvseriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  // external
  // final client = await SecureHttpClient.secureCertificatedClient();
  locator.registerSingletonAsync<http.Client>(() => SecureConnect.SecureHttp());
}
