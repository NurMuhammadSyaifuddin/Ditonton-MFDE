import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_watchlist_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  MovieWatchlistBloc(this._getWatchlistMovies): super(MovieEmpty()){
    on<WatchlistMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold((failure){
        emit(MovieError(failure.message));
      }, (data){
        emit(MovieHashData(data));
      });
    });
  }
}