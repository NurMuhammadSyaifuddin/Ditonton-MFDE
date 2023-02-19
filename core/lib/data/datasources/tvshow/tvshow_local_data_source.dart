
import '../../../utils/exception.dart';
import '../../models/tvshow/tvshow_table.dart';
import '../db/database_helper.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlist(TvShowTable tvshow);
  Future<String> removeWatchlist(TvShowTable tvshow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getWatchlistTvShow();
}

class TvShowLocalDataSourceImpl extends TvShowLocalDataSource {

  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null){
      return TvShowTable.fromMap(result);
    }
    return null;
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShow() async {
    final result = await databaseHelper.getWatchlistTvShow();
    return result.map((e) => TvShowTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlist(TvShowTable tvshow) async {
    try {
      await databaseHelper.insertWatchlistTvShow(tvshow);
      return 'Added to Watchlist';
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvShowTable tvshow) async {
    try {
      await databaseHelper.removeWatchlistTvShow(tvshow);
      return 'Removed from Watchlist';
    }catch (e) {
      throw DatabaseException(e.toString());
    }
  }

}