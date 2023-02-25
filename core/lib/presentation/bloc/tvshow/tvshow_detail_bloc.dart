import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/presentation/bloc/movie/movie_event.dart';
import 'package:core/presentation/bloc/movie/movie_state.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_movie_detail.dart';

class TvShowDetailBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailBloc(this._getTvShowDetail) : super(TvShowEmpty()) {
    on<DetailTvShow>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getTvShowDetail.execute(event.id);

      result.fold((failure) {
        emit(TvShowError(failure.message));
      }, (data) {
        emit(TvShowDetailHashData(data));
      });
    });
  }

}
