import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieRemoveWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final RemoveWatchlist _removeWatchlist;

  MovieRemoveWatchlistBloc(this._removeWatchlist) : super(MovieEmpty()) {
    on<RemoveMovieWatchlist>((event, emit) async {

      emit(MovieLoading());

      final result = await _removeWatchlist.execute(event.movieDetail);

      result.fold((failure) => emit(MovieError(failure.message)), (data) => emit(MovieHashDataString(data)));
    });

    on<WatchListDetailStatus>((event, emit) async {
      emit(MovieDetailWatchlistStatus(false));
    });
  }
}