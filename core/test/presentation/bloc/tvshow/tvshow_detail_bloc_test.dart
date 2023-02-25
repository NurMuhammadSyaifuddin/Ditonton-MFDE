import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshow.dart';
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_add_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_remove_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tvshow_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListStatusTvShow,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockSaveWatchlistTvShow mockSaveWatchlist;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;
  late TvShowDetailBloc tvShowDetailBloc;
  late TvShowDetailRecommendationBloc tvShowDetailRecommendationBloc;
  late TvShowAddWatchlistBloc tvShowAddWatchlistBloc;
  late TvShowRemoveWatchlistBloc tvShowRemoveWatchlistBloc;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockSaveWatchlist = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    tvShowDetailBloc = TvShowDetailBloc(mockGetTvShowDetail);
    tvShowDetailRecommendationBloc = TvShowDetailRecommendationBloc(mockGetTvShowRecommendations);
    tvShowAddWatchlistBloc = TvShowAddWatchlistBloc(mockSaveWatchlist);
    tvShowRemoveWatchlistBloc = TvShowRemoveWatchlistBloc(mockRemoveWatchlist);
  });

  const tId = 1;

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

  final tTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1, genres: [Genre(id: 1, name: 'name')], originalLanguage: 'en',
  );

  group('Get TvShow Detail', ()
  {
    blocTest<TvShowDetailBloc, TvShowState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTvShowDetail.execute(tId))
              .thenAnswer((_) async => Right(tTvShowDetail));
          return tvShowDetailBloc;
        },
        act: (bloc) => bloc.add(const DetailTvShow(tId)),
        wait: const Duration(milliseconds: 1000),
        expect: () =>
        [
          TvShowLoading(),
          TvShowDetailHashData(tTvShowDetail)
        ]);

    blocTest<TvShowDetailRecommendationBloc, TvShowState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTvShowRecommendations.execute(tId))
              .thenAnswer((_) async => Right([tTvShow]));
          return tvShowDetailRecommendationBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTvShow(tId)),
        wait: const Duration(milliseconds: 1000),
        expect: () =>
        [
          TvShowLoading(),
          TvShowHashData([tTvShow])
        ]);


    group('Watchlist', () {
      blocTest<TvShowAddWatchlistBloc, TvShowState>(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchlist.execute(tTvShowDetail))
                .thenAnswer((_) async => const Right('Added to watchlist'));
            return tvShowAddWatchlistBloc;
          },
          act: (bloc) => bloc.add(AddTvShowWatchlist(tTvShowDetail)),
          wait: const Duration(milliseconds: 1000),
          expect: () =>
          [
            TvShowLoading(),
            const TvShowHashDataString('Added to watchlist'),
          ]);

      blocTest<TvShowRemoveWatchlistBloc, TvShowState>(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlist.execute(tTvShowDetail))
                .thenAnswer((_) async => const Right('Remove from watchlist'));
            return tvShowRemoveWatchlistBloc;
          },
          act: (bloc) => bloc.add(RemoveTvShowWatchlist(tTvShowDetail)),
          wait: const Duration(milliseconds: 1000),
          expect: () =>
          [
            TvShowLoading(),
            const TvShowHashDataString('Remove from watchlist')
          ]);

    });


  });

}
