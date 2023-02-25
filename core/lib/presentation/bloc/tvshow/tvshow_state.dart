import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvshow/tvshow.dart';

abstract class TvShowState extends Equatable {
  const TvShowState();

  @override
  List<Object?> get props => [];
}

class TvShowEmpty extends TvShowState {}

class TvShowLoading extends TvShowState{}

class TvShowError extends TvShowState {
  final String message;

  const TvShowError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvShowHashData extends TvShowState {
  final List<TvShow> result;

  const TvShowHashData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvShowDetailHashData extends TvShowState {
  final TvShowDetail result;

  const TvShowDetailHashData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvShowDetailWatchlistStatus extends TvShowState {
  final bool result;

  const TvShowDetailWatchlistStatus(this.result);

  @override
  List<Object?> get props => [result];
}

class TvShowHashDataString extends TvShowState {
  final String result;

  const TvShowHashDataString(this.result);

  @override
  List<Object?> get props => [result];
}