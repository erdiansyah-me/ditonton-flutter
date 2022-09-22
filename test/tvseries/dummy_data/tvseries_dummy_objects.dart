import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:ditonton/domain/entities/genre.dart';

final testTvseries = Tvseries(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1,2,3],
  id: 1,
  name: 'name',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

final testTvseriesList = [testTvseries];

final testTvseriesDetail = TvseriesDetail(
  backdropPath: 'backdropPath',
  firstAirDate: DateTime(2021),
  genres: [Genre(id: 1, name: 'action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: ['En'],
  lastAirDate: DateTime(2021),
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistSeries = Tvseries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvseriesTable = TvseriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvseriesMap = {
  'id': 1,
  'overview':'overview',
  'posterPath':'posterPath',
  'name':'name',
};
