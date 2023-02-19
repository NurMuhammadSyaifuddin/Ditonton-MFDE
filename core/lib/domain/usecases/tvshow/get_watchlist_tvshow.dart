import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tvshow/tvshow.dart';
import '../../repositories/tvshow_repository.dart';

class GetWatchlistTvShow {
  final TvShowRepository _repository;

  GetWatchlistTvShow(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchListTvShow();
  }
}
