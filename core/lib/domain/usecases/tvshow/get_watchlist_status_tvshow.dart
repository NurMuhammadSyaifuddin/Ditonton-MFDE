
import '../../repositories/tvshow_repository.dart';

class GetWatchListStatusTvShow {
  final TvShowRepository repository;

  GetWatchListStatusTvShow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchList(id);
  }
}
