
import '../../../../common/exception.dart';
import '../../../models/tv/tv_table.dart';
import '../../db/database_tv_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tvTable);

  Future<String> removeWatchlistTv(TvTable tvTable);

  Future<TvTable?> getTvById(int id);

  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseTvHelper databaseHelperTv;

  TvLocalDataSourceImpl({required this.databaseHelperTv});

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelperTv.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelperTv.getWatchlistTv();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvTable tvTable) async {
    try {
      await databaseHelperTv.insertWatchlistTv(tvTable);
      return 'Added to watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tvTable) async {
    try {
      await databaseHelperTv.removeWatchList(tvTable);
      return 'Remove from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}