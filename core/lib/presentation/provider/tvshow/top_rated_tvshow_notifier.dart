import 'package:flutter/foundation.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/usecases/tvshow/get_top_rated_tvshow.dart';
import '../../../utils/state_enum.dart';

class TopRatedTvShowNotifier extends ChangeNotifier {
  final GetTopRatedTvShow getTopRatedTvShow;

  TopRatedTvShowNotifier({required this.getTopRatedTvShow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvshow = [];
  List<TvShow> get tvshow => _tvshow;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();

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
