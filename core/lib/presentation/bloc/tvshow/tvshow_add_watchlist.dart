import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowAddWatchlistBloc extends Bloc<TvShowEvent, TvShowState> {
  final SaveWatchlistTvShow _saveWatchlist;

  TvShowAddWatchlistBloc(this._saveWatchlist) : super(TvShowEmpty()) {
    on<AddTvShowWatchlist>((event, emit) async {

      emit(TvShowLoading());

      final result = await _saveWatchlist.execute(event.tvShowDetail);

      result.fold((failure) => emit(TvShowError(failure.message)), (data) => emit(TvShowHashDataString(data)));
    });

    on<WatchListDetailTvShowStatus>((event, emit) async {
      emit(const TvShowDetailWatchlistStatus(true));
    });
  }
}