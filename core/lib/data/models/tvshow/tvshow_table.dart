import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/entities/tvshow/tvshow_detail.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvShowTable({required this.id, required this.name, required this.posterPath, required this.overview});

  factory TvShowTable.fromEntity(TvShowDetail tvshow) => TvShowTable(
    id: tvshow.id,
    name: tvshow.name,
    posterPath: tvshow.posterPath,
    overview: tvshow.overview,
  );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
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

  TvShow toEntity() => TvShow.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview
  ];

}