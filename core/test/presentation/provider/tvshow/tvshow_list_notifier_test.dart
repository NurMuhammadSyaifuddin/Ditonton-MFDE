import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_airing_today_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:core/presentation/provider/tvshow/tvshow_list_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvShow, GetPopularTvShow, GetTopRatedTvShow])
void main() {
  late TvShowListNotifier provider;
  late MockGetAiringTodayTvShow mockGetAiringTodayTvShow;
  late MockGetPopularTvShow mockGetPopularTvShow;
  late MockGetTopRatedTvShow mockGetTopRatedTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvShow = MockGetAiringTodayTvShow();
    mockGetPopularTvShow = MockGetPopularTvShow();
    mockGetTopRatedTvShow = MockGetTopRatedTvShow();
    provider = TvShowListNotifier(
      getAiringTodayTvShow: mockGetAiringTodayTvShow,
      getPopularTvShow: mockGetPopularTvShow,
      getTopRatedTvShow: mockGetTopRatedTvShow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvShowList = <TvShow>[tTvShow];

  group('Airing Today Tv Show', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchAiringTodayTvShow();
      // assert
      verify(mockGetAiringTodayTvShow.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchAiringTodayTvShow();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchAiringTodayTvShow();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvShow, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTvShow();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Loaded);
      expect(provider.popularTvShow, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loading);
    });

    test('should change tvshow data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loaded);
      expect(provider.topRatedTvShow, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
