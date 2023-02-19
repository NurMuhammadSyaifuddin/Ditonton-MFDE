import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tvshow/tvshow_detail.dart';
import '../../repositories/tvshow_repository.dart';

class RemoveWatchlistTvShow {
  final TvShowRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvshow) {
    return repository.removeWatchList(tvshow);
  }
}
