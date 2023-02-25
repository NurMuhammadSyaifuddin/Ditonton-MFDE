import 'package:core/domain/usecases/tvshow/search_tvshow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/bloc/tvshow/search_tvshow_event.dart';
import 'package:search/bloc/tvshow/search_tvshow_state.dart';

class SearchTvShowBloc extends Bloc<SearchTvShowEvent, SearchTvShowState> {
  final SearchTvShow _searchTvShow;

  SearchTvShowBloc(this._searchTvShow) : super(SearchTvShowEmpty()) {
    on<OnQueryTvShowChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvShowLoading());
      final result = await _searchTvShow.execute(query);

      result.fold(
            (failure) {
          emit(SearchTvShowError(failure.message));
        },
            (data) {
          emit(SearchTvShowHasData(data));
        }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration){
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}