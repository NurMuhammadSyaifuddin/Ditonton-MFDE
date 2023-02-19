import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tvshow/tvshow_detail.dart';
import '../../repositories/tvshow_repository.dart';

class SaveWatchlistTvShow {
  final TvShowRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvshow) {
    return repository.saveWatchList(tvshow);
  }
}
