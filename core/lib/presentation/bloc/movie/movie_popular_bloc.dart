import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_popular_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MoviePopularBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies): super(MovieEmpty()){
    on<PopularMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold((failure){
        emit(MovieError(failure.message));
      }, (data){
        emit(MovieHashData(data));
      });
    });
  }
}