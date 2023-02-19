import 'package:flutter/material.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/usecases/tvshow/get_airing_today_tvshow.dart';
import '../../../domain/usecases/tvshow/get_popular_tvshow.dart';
import '../../../domain/usecases/tvshow/get_top_rated_tvshow.dart';
import '../../../utils/state_enum.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _airingTodayTvShow = <TvShow>[];
  List<TvShow> get airingTodayTvShow => _airingTodayTvShow;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _popularTvShow = <TvShow>[];
  List<TvShow> get popularTvShow => _popularTvShow;

  RequestState _popularTvShowState = RequestState.Empty;
  RequestState get popularTvShowState => _popularTvShowState;

  var _topRatedTvShow = <TvShow>[];
  List<TvShow> get topRatedTvShow => _topRatedTvShow;

  RequestState _topRatedTvShowState = RequestState.Empty;
  RequestState get topRatedTvShowState => _topRatedTvShowState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getAiringTodayTvShow,
    required this.getPopularTvShow,
    required this.getTopRatedTvShow,
  });

  final GetAiringTodayTvShow getAiringTodayTvShow;
  final GetPopularTvShow getPopularTvShow;
  final GetTopRatedTvShow getTopRatedTvShow;

  Future<void> fetchAiringTodayTvShow() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvShow.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTvShow = tvshowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShow() async {
    _popularTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();
    result.fold(
      (failure) {
        _popularTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowData) {
        _popularTvShowState = RequestState.Loaded;
        _popularTvShow = tvshowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShow() async {
    _topRatedTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();
    result.fold(
      (failure) {
        _topRatedTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowData) {
        _topRatedTvShowState = RequestState.Loaded;
        _topRatedTvShow = tvshowData;
        notifyListeners();
      },
    );
  }
}
