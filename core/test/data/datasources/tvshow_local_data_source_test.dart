
import 'package:core/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowMap);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, testTvShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowMap]);
      // act
      final result = await dataSource.getWatchlistTvShow();
      // assert
      expect(result, [testTvShowTable]);
    });
  });
}
