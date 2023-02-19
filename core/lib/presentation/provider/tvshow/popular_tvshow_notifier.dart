import 'package:flutter/foundation.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../domain/usecases/tvshow/get_popular_tvshow.dart';
import '../../../utils/state_enum.dart';

class PopularTvShowNotifier extends ChangeNotifier {
  final GetPopularTvShow getPopularTvShow;

  PopularTvShowNotifier(this.getPopularTvShow);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvshow = [];
  List<TvShow> get tvshow => _tvshow;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();

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
