import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailRecommendationBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetTvShowRecommendations _getTvShowRecommendations;
  
  TvShowDetailRecommendationBloc(this._getTvShowRecommendations): super(TvShowEmpty()){
    on<RecommendationTvShow>((event, emit) async {
      emit(TvShowLoading());
      final result = await _getTvShowRecommendations.execute(event.id);

      result.fold((failure) {
        emit(TvShowError(failure.message));
      }, (data) {
        emit(TvShowHashData(data));
      });
    });
  }
}