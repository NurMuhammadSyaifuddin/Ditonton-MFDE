// ignore_for_file: file_names

import '../../../domain/usecases/movie/get_now_playing_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieNowPlayingBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies): super(MovieEmpty()){
    on<NowPlayingMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure){
        emit(MovieError(failure.message));
      }, (data){
        emit(MovieHashData(data));
      });
    });
  }
}