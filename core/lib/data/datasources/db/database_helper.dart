import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../models/movie/movie_table.dart';
import '../../models/tvshow/tvshow_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistMovie = 'watchlist_movie';
  static const String _tblWatchlistTvShow = 'watchlist_tvshow';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
    CREATE TABLE $_tblWatchlistTvShow (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      posterPath TEXT
    );
    ''');
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovie, movie.toJson());
  }

  Future<int> insertWatchlistTvShow(TvShowTable tvshow) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvShow, tvshow.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeWatchlistTvShow(TvShowTable tvshow) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [tvshow.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistMovie);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShow() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
    await db!.query(_tblWatchlistTvShow);

    return results;
  }

}
