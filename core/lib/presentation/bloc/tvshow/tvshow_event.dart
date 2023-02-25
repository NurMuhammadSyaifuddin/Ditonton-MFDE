import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object?> get props => [];
}

class DetailTvShow extends TvShowEvent {
  final int id;

  const DetailTvShow(this.id);
  @override
  List<Object?> get props => [id];
}

class WatchListDetailTvShowStatus extends TvShowEvent {
  final int id;

  const WatchListDetailTvShowStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AiringTodayTvShow extends TvShowEvent {

  const AiringTodayTvShow();

  @override
  List<Object?> get props => [];
}

class PopularTvShow extends TvShowEvent {

  const PopularTvShow();

  @override
  List<Object?> get props => [];
}

class TopRatedTvShow extends TvShowEvent{

  const TopRatedTvShow();

  @override
  List<Object?> get props => [];
}

class TvShowWatchlist extends TvShowEvent {

  const TvShowWatchlist();

  @override
  List<Object?> get props => [];
}

class AddTvShowWatchlist extends TvShowEvent {
  final TvShowDetail tvShowDetail;

  const AddTvShowWatchlist(this.tvShowDetail);

  @override
  List<Object?> get props => [tvShowDetail];
}

class RemoveTvShowWatchlist extends TvShowEvent {
  final TvShowDetail tvShowDetail;

  const RemoveTvShowWatchlist(this.tvShowDetail);

  @override
  List<Object?> get props => [tvShowDetail];
}

class RecommendationTvShow extends TvShowEvent {
  final int id;

  const RecommendationTvShow(this.id);
  @override
  List<Object?> get props => [id];
}

