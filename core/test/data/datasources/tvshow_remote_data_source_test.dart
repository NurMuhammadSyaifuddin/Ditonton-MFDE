import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/tvshow/tvshow_remote_data_source.dart';
import 'package:core/data/models/tvshow/tvshow_detail_model.dart';
import 'package:core/data/models/tvshow/tvshow_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=3f439738eb048143ce0cdfba822268a6';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Airing Today Tv Show', () {
    final tTvShowLlist = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/airing_today.json')))
        .tvshowList;

    test('should return list of TvShow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/airing_today.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getAiringTodayTvShow();
      // assert
      expect(result, equals(tTvShowLlist));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getAiringTodayTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Show', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tvshow.json')))
        .tvshowList;

    test('should return list of tv show when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tvshow.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getPopularTvShow();
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getPopularTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Show', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tvshow.json')))
        .tvshowList;

    test('should return list of tv show when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tvshow.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTopRatedTvShow();
      // assert
      expect(result, tTvShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getTopRatedTvShow();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    const tId = 1;
    final tTvShowDetail = TvShowDetailModel.fromJson(
        json.decode(readJson('dummy_data/tvshow_detail.json')));

    test('should return tv show detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tvshow_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tTvShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getTvShowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow_recommendations.json')))
        .tvshowList;
    const tId = 1;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tvshow_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvShowRecommendations(tId);
      // assert
      expect(result, equals(tTvShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getTvShowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv show', () {
    final tSearchResult = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/search_tvshow.json')))
        .tvshowList;
    const tQuery = 'Julekalender';

    test('should return list of tv show when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_tvshow.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.searchTvShow(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.searchTvShow(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
