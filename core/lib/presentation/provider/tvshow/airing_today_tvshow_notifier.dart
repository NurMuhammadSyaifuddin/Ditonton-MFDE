import 'package:flutter/foundation.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/usecases/tvshow/get_airing_today_tvshow.dart';
import '../../../utils/state_enum.dart';

class AiringTodayTvShowNotifier extends ChangeNotifier {
  final GetAiringTodayTvShow getAiringTodayTvShow;

  AiringTodayTvShowNotifier(this.getAiringTodayTvShow);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvshow = [];
  List<TvShow> get tvshow => _tvshow;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvShow.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvshowData) {
        _tvshow = tvshowData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
