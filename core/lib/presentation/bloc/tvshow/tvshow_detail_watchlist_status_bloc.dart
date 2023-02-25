import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailWatchlistStatusBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetWatchListStatusTvShow _getWatchlistStatus;
  TvShowDetailWatchlistStatusBloc(this._getWatchlistStatus) : super(TvShowEmpty()) {
    on<WatchListDetailTvShowStatus>((event, emit) async {
      final result = await _getWatchlistStatus.execute(event.id);
      emit(TvShowDetailWatchlistStatus(result));
    });
  }
}