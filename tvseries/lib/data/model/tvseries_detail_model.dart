import 'dart:convert';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/data/model/genre_model.dart';

TvseriesDetailResponse tvseriesDetailResponseFromJson(String str) =>
    TvseriesDetailResponse.fromJson(json.decode(str));
    
class TvseriesDetailResponse extends Equatable {
  TvseriesDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final DateTime? firstAirDate;
  final List<GenreModel>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  factory TvseriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvseriesDetailResponse(
        backdropPath: json["backdrop_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  TvseriesDetail toEntity() {
    return TvseriesDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres?.map((genre) => genre.toEntity()).toList(),
        homepage: this.homepage,
        id: this.id,
        inProduction: this.inProduction,
        languages: this.languages,
        lastAirDate: this.lastAirDate,
        name: this.name,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
