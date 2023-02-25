import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie/movie.dart';

abstract class MovieState extends Equatable {

  const MovieState();

  @override
  List<Object?> get props => [];

}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}
class MovieRecommendationLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
class MovieRecommendationError extends MovieState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHashData extends MovieState {
  final List<Movie> result;

  const MovieHashData(this.result);

  @override
  List<Object> get props => [result];
}
class MovieRecommendationHashData extends MovieState {
  final List<Movie> result;

  const MovieRecommendationHashData(this.result);

  @override
  List<Object> get props => [result];
}

// ignore: must_be_immutable
class MovieDetailHashData extends MovieState {
  final MovieDetail result;

  const MovieDetailHashData(this.result);

  @override
  List<Object?> get props => [result];
}

class MovieHashDataString extends MovieState {
  final String result;

const MovieHashDataString(this.result);

  @override
  List<Object?> get props => [result];
}

// ignore: must_be_immutable
class MovieDetailWatchlistStatus extends MovieState {
  bool result;

  MovieDetailWatchlistStatus(this.result);

  @override
  List<Object?> get props => [result];
}