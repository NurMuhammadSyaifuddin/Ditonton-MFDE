import 'package:core/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowTopRatedBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetTopRatedTvShow _getTopRatedTvShow;

  TvShowTopRatedBloc(this._getTopRatedTvShow): super(TvShowEmpty()){
    on<TopRatedTvShow>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getTopRatedTvShow.execute();
      result.fold((failure){
        emit(TvShowError(failure.message));
      }, (data){
        emit(TvShowHashData(data));
      });
    });
  }
}