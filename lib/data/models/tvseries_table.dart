import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/domain/entities/Tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvseriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvseriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvseriesTable.fromEntity(TvseriesDetail series) => TvseriesTable(
        id: series.id,
        name: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  factory TvseriesTable.fromMap(Map<String, dynamic> map) => TvseriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Tvseries toEntity() => Tvseries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];

}