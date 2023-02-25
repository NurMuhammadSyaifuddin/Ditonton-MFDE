import 'package:core/domain/usecases/tvshow/get_watchlist_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowWatchlistBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetWatchlistTvShow _getWatchlistTvShow;

  TvShowWatchlistBloc(this._getWatchlistTvShow): super(TvShowEmpty()){
    on<TvShowWatchlist>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getWatchlistTvShow.execute();
      result.fold((failure){
        emit(TvShowError(failure.message));
      }, (data){
        emit(TvShowHashData(data));
      });
    });
  }
}