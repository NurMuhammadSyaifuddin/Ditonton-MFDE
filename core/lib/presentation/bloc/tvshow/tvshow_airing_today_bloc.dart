// ignore_for_file: file_names

import 'package:core/domain/usecases/tvshow/get_airing_today_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowAiringTodayBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetAiringTodayTvShow _getAiringTodayTvShow;

  TvShowAiringTodayBloc(this._getAiringTodayTvShow): super(TvShowEmpty()){
    on<AiringTodayTvShow>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getAiringTodayTvShow.execute();
      result.fold((failure){
        emit(TvShowError(failure.message));
      }, (data){
        emit(TvShowHashData(data));
      });
    });
  }
}