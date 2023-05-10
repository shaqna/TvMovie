
import 'package:equatable/equatable.dart';
import 'package:tv_movie_app/data/models/tv/tv_model.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';

class TvTable extends Equatable{
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview
  });

  factory TvTable.fromEntity(TvDetail tvDetail) => TvTable(
      id: tvDetail.id,
      name: tvDetail.name,
      posterPath: tvDetail.posterPath,
      overview: tvDetail.overview
  );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
    id: map["id"],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  factory TvTable.fromDTO(TvModel tvModel) => TvTable(
      id: tvModel.id,
      name: tvModel.name,
      posterPath: tvModel.posterPath,
      overview: tvModel.overview
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Tv toEntity() => Tv.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    overview: overview,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview,
  ];


}