import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_top_rated_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieTopRatedBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies): super(MovieEmpty()){
    on<TopRatedMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((failure){
        emit(MovieError(failure.message));
      }, (data){
        emit(MovieHashData(data));
      });
    });
  }
}