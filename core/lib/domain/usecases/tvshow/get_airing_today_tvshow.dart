import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tvshow/tvshow.dart';
import '../../repositories/tvshow_repository.dart';

class GetAiringTodayTvShow {
  final TvShowRepository repository;

  GetAiringTodayTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getAiringTodayTvShow();
  }
}
