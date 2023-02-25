import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieDetailRecommendationBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;
  
  MovieDetailRecommendationBloc(this._getMovieRecommendations): super(MovieEmpty()){
    on<RecommendationMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieHashData(data));
      });
    });
  }
}