import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie/movie_detail.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class DetailMovie extends MovieEvent {
  final int id;

  const DetailMovie(this.id);
  @override
  List<Object?> get props => [id];
}

class RecommendationMovie extends MovieEvent {
  final int id;

  const RecommendationMovie(this.id);
  @override
  List<Object?> get props => [id];
}

class WatchListDetailStatus extends MovieEvent {
  final int id;

  const WatchListDetailStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;

  const AddMovieWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class RemoveMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;

  const RemoveMovieWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class NowPlayingMovies extends MovieEvent {

  const NowPlayingMovies();

  @override
  List<Object?> get props => [];
}

class PopularMovies extends MovieEvent {

  const PopularMovies();

  @override
  List<Object?> get props => [];
}

class TopRatedMovies extends MovieEvent {

  const TopRatedMovies();

  @override
  List<Object?> get props => [];
}

class WatchlistMovies extends MovieEvent {

  const WatchlistMovies();

  @override
  List<Object?> get props => [];
}

class MessageMovieWatchlist extends MovieEvent {

  final String message;

  const MessageMovieWatchlist(this.message);

  @override
  List<Object?> get props => [message];
}