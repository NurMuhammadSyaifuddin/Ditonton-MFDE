import 'package:flutter/foundation.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/usecases/tvshow/get_watchlist_tvshow.dart';
import '../../../utils/state_enum.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  var _watchlistTvShow = <TvShow>[];
  List<TvShow> get watchlistTvShow => _watchlistTvShow;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvShowNotifier({required this.getWatchlistTvShow});

  final GetWatchlistTvShow getWatchlistTvShow;

  Future<void> fetchWatchlistTvShow() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShow.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShow = tvshowData;
        notifyListeners();
      },
    );
  }
}
