import 'package:core/presentation/bloc/movie/movie_event.dart';
import 'package:core/presentation/bloc/movie/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_movie_detail.dart';

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieEmpty()) {
    on<DetailMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(MovieError(failure.message));
      }, (data) {
        emit(MovieDetailHashData(data));
      });
    });


  }

}
