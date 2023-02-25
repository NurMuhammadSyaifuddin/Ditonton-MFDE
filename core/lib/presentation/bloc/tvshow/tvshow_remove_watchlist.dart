import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowRemoveWatchlistBloc extends Bloc<TvShowEvent, TvShowState> {
  final RemoveWatchlistTvShow _removeTvShowWatchlist;

  TvShowRemoveWatchlistBloc(this._removeTvShowWatchlist) : super(TvShowEmpty()) {
    on<RemoveTvShowWatchlist>((event, emit) async {

      emit(TvShowLoading());

      final result = await _removeTvShowWatchlist.execute(event.tvShowDetail);

      result.fold((failure) => emit(TvShowError(failure.message)), (data) => emit(TvShowHashDataString(data)));
    });

    on<WatchListDetailTvShowStatus>((event, emit) async {
      emit(const TvShowDetailWatchlistStatus(false));
    });
  }
}