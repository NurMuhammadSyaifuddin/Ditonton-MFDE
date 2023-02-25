import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowPopularBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetPopularTvShow _getPopularTvShow;

  TvShowPopularBloc(this._getPopularTvShow): super(TvShowEmpty()){
    on<PopularTvShow>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getPopularTvShow.execute();
      result.fold((failure){
        emit(TvShowError(failure.message));
      }, (data){
        emit(TvShowHashData(data));
      });
    });
  }
}