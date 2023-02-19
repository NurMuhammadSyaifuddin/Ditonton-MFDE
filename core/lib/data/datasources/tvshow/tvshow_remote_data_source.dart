import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utils/exception.dart';
import '../../models/tvshow/tvshow_detail_model.dart';
import '../../models/tvshow/tvshow_model.dart';
import '../../models/tvshow/tvshow_response.dart';
import '../../utils.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getAiringTodayTvShow();
  Future<List<TvShowModel>> getPopularTvShow();
  Future<List<TvShowModel>> getTopRatedTvShow();
  Future<TvShowDetailModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> getTvShowRecommendations(int id);
  Future<List<TvShowModel>> searchTvShow(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {

  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvShowModel>> getAiringTodayTvShow() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvshowList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvShowModel>> getPopularTvShow() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvshowList;
    }

    throw ServerException();
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShow() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvshowList;
    }

    throw ServerException();
  }

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200){
      return TvShowDetailModel.fromJson(json.decode(response.body));
    }
    throw ServerException();
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvshowList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvShowModel>> searchTvShow(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvshowList;
    }
    throw ServerException();
  }
  
}