import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/entities/tvshow/tvshow_detail.dart';
import '../../../domain/usecases/tvshow/get_tvshow_detail.dart';
import '../../../domain/usecases/tvshow/get_tvshow_recommendations.dart';
import '../../../domain/usecases/tvshow/get_watchlist_status_tvshow.dart';
import '../../../domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import '../../../domain/usecases/tvshow/save_watchlist_tvshow.dart';
import '../../../utils/state_enum.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchListStatusTvShow getWatchListStatusTvShow;
  final SaveWatchlistTvShow saveWatchlistTvShow;
  final RemoveWatchlistTvShow removeWatchlistTvShow;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListStatusTvShow,
    required this.saveWatchlistTvShow,
    required this.removeWatchlistTvShow,
  });

  late TvShowDetail _tvshow;
  TvShowDetail get tvshow => _tvshow;

  RequestState _tvshowState = RequestState.Empty;
  RequestState get tvshowState => _tvshowState;

  List<TvShow> _tvshowRecommendations = [];
  List<TvShow> get tvshowRecommendations => _tvshowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvShowDetail(int id) async {
    _tvshowState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResult = await getTvShowRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvshowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshow) {
        _recommendationState = RequestState.Loading;
        _tvshow = tvshow;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _tvshowRecommendations = movies;
          },
        );
        _tvshowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvshow) async {
    final result = await saveWatchlistTvShow.execute(tvshow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvshow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvshow) async {
    final result = await removeWatchlistTvShow.execute(tvshow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvshow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTvShow.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
