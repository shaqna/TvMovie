import 'package:equatable/equatable.dart';
import 'package:tv_movie_app/data/models/tv/tv_model.dart';

class TvResponse extends Equatable{
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    tvList: List<TvModel>.from((json['results'] as List)
        .map((e) => TvModel.fromJson(e))
        .where((element) => element.backdropPath != null)
    ),
  );

  Map<String, dynamic> toJson() => {
    'results' : List<dynamic>.from(tvList.map((e) => e.toJson())),
  };

  @override
  List<Object?> get props => [
    tvList,
  ];
}