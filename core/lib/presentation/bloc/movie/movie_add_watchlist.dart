import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieAddWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final SaveWatchlist _saveWatchlist;

  MovieAddWatchlistBloc(this._saveWatchlist) : super(MovieEmpty()) {
    on<AddMovieWatchlist>((event, emit) async {

      emit(MovieLoading());

      final result = await _saveWatchlist.execute(event.movieDetail);

      result.fold((failure) => emit(MovieError(failure.message)), (data) => emit(MovieHashDataString(data)));
    });

    on<WatchListDetailStatus>((event, emit) async {
      emit(MovieDetailWatchlistStatus(true));
    });
  }
}