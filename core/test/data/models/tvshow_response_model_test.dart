import 'dart:convert';

import 'package:core/data/models/tvshow/tvshow_model.dart';
import 'package:core/data/models/tvshow/tvshow_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: "/qcpC9lv6VLL4Zw45EveYELyje1w.jpg",
    genreIds: const [18, 10766, 10751],
    id: 111453,
    originalName: "घुम है किसिकी प्यार में",
    overview: "Virat sacrifices his love to honour the promise he made to a dying man. Trapped between the past and the present, will he find love beyond the chains of duty?",
    popularity: 1780.011,
    posterPath: "/uNjnoT3RChs2r7O9pDyx7TNBvIj.jpg",
    firstAirDate: "2020-10-05",
    name: "Gumm Hai Kisi Ke Pyaar Mein",
    voteAverage: 5.5,
    voteCount: 24,
  );
  final tTvShowResponseModel =
      TvShowResponse(tvshowList: <TvShowModel>[tTvShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/qcpC9lv6VLL4Zw45EveYELyje1w.jpg",
            "genre_ids": [18, 10766, 10751],
            "id": 111453,
            "original_name": "घुम है किसिकी प्यार में",
            "overview": "Virat sacrifices his love to honour the promise he made to a dying man. Trapped between the past and the present, will he find love beyond the chains of duty?",
            "popularity": 1780.011,
            "poster_path": "/uNjnoT3RChs2r7O9pDyx7TNBvIj.jpg",
            "first_air_date": "2020-10-05",
            "name": "Gumm Hai Kisi Ke Pyaar Mein",
            "vote_average": 5.5,
            "vote_count": 24,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
