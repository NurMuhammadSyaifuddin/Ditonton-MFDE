import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tvshow/tvshow.dart';
import '../entities/tvshow/tvshow_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShow();
  Future<Either<Failure, List<TvShow>>> getPopularTvShow();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShow(String query);
  Future<Either<Failure, String>> saveWatchList(TvShowDetail tvshow);
  Future<Either<Failure, String>> removeWatchList(TvShowDetail tvshow);
  Future<bool> isAddedToWatchList(int id);
  Future<Either<Failure, List<TvShow>>> getWatchListTvShow();
}