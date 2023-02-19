import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/tvshow/tvshow.dart';
import '../../domain/entities/tvshow/tvshow_detail.dart';
import '../../domain/repositories/tvshow_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../datasources/tvshow/tvshow_local_data_source.dart';
import '../datasources/tvshow/tvshow_remote_data_source.dart';
import '../models/tvshow/tvshow_table.dart';

class TvShowRepositoryImpl extends TvShowRepository {

  final TvShowRemoteDataSource remoteDataSource;
  final TvShowLocalDataSource localDataSource;

  TvShowRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShow() async {
    try {
      final result = await remoteDataSource.getAiringTodayTvShow();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShow() async {
    try {
      final result = await remoteDataSource.getPopularTvShow();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow() async {
    try {
      final result = await remoteDataSource.getTopRatedTvShow();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvShowRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchListTvShow() async {
    final result = await localDataSource.getWatchlistTvShow();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchList(int id) async {
    final result = await localDataSource.getTvShowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchList(TvShowDetail tvshow) async {
    try {
      final result = await localDataSource.removeWatchlist(TvShowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchList(TvShowDetail tvshow) async {
    try {
      final result = await localDataSource.insertWatchlist(TvShowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    } catch (e){
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShow(String query) async {
    try {
      final result = await remoteDataSource.searchTvShow(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}