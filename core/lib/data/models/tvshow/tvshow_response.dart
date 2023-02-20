import 'package:core/data/models/tvshow/tvshow_model.dart';
import 'package:equatable/equatable.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> tvshowList;

  const TvShowResponse({required this.tvshowList});

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
      tvshowList: List<TvShowModel>.from((json['results'] as List)
      .map((e) => TvShowModel.fromJson(e))
      .where((element) => element.posterPath != null || element.backdropPath != null ||element.firstAirDate != null)));

  Map<String, dynamic> toJson() => {
    'results' : List<dynamic>.from(tvshowList.map((e) => e.toJson()))
  };

  @override
  List<Object?> get props => [tvshowList];
}
