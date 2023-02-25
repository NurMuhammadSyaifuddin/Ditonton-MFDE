import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieDetailWatchlistStatusBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchListStatus _getWatchlistStatus;
  MovieDetailWatchlistStatusBloc(this._getWatchlistStatus) : super(MovieEmpty()) {
    on<WatchListDetailStatus>((event, emit) async {
      final result = await _getWatchlistStatus.execute(event.id);
      emit(MovieDetailWatchlistStatus(result));
    });
  }
}