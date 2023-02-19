import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/usecase/search_tvshow.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShow searchTvShow;

  TvShowSearchNotifier({required this.searchTvShow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _searchResult = [];
  List<TvShow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShow.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvshowData) {
        _searchResult = tvshowData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
