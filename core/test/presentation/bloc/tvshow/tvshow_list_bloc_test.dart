// import 'package:bloc_test/bloc_test.dart';
// import 'package:core/domain/entities/tvshow/tvshow.dart';
// import 'package:core/domain/usecases/tvshow/get_airing_today_tvshow.dart';
// import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart';
// import 'package:core/domain/usecases/tvshow/get_top_rated_tvshow.dart';
// import 'package:core/presentation/bloc/tvshow/tvshow_airing_today_bloc.dart';
// import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
// import 'package:core/presentation/bloc/tvshow/tvshow_popular_bloc.dart';
// import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
// import 'package:core/presentation/bloc/tvshow/tvshow_top_rated_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'tvshow_list_bloc_test.mocks.dart';
//
// @GenerateMocks([GetAiringTodayTvShow, GetPopularTvShow, GetTopRatedTvShow])
// void main() {
//   late MockGetAiringTodayTvShow mockGetAiringTodayTvShow;
//   late MockGetPopularTvShow mockGetPopularTvShow;
//   late MockGetTopRatedTvShow mockGetTopRatedTvShow;
//   late TvShowAiringTodayBloc tvShowAiringTodayBloc;
//   late TvShowPopularBloc tvShowPopularBloc;
//   late TvShowTopRatedBloc tvShowTopRatedBloc;
//
//   setUp(() {
//     mockGetAiringTodayTvShow = MockGetAiringTodayTvShow();
//     mockGetPopularTvShow = MockGetPopularTvShow();
//     mockGetTopRatedTvShow = MockGetTopRatedTvShow();
//     tvShowAiringTodayBloc = TvShowAiringTodayBloc(mockGetAiringTodayTvShow);
//     tvShowPopularBloc = TvShowPopularBloc(mockGetPopularTvShow);
//     tvShowTopRatedBloc = TvShowTopRatedBloc(mockGetTopRatedTvShow);
//   });
//
//   final tTvShow = TvShow(
//     backdropPath: 'backdropPath',
//     genreIds: const [1, 2, 3],
//     id: 1,
//     originalName: 'originalName',
//     overview: 'overview',
//     popularity: 1,
//     posterPath: 'posterPath',
//     firstAirDate: 'firstAirDate',
//     name: 'name',
//     voteAverage: 1,
//     voteCount: 1,
//   );
//   final tTvShowList = <TvShow>[tTvShow];
//
//   group('Tv Show', () {
//     blocTest<TvShowAiringTodayBloc, TvShowState>(
//         'Should emit [Loading, HasData] when data is gotten successfully',
//         build: () {
//           when(mockGetAiringTodayTvShow.execute())
//               .thenAnswer((_) async => Right(tTvShowList));
//           return tvShowAiringTodayBloc;
//         },
//         act: (bloc) => bloc.add(const AiringTodayTvShow()),
//         wait: const Duration(milliseconds: 1000),
//         expect: () => [TvShowLoading(), TvShowHashData(tTvShowList)]);
//
//     blocTest<TvShowPopularBloc, TvShowState>(
//         'Should emit [Loading, HasData] when data is gotten successfully',
//         build: () {
//           when(mockGetPopularTvShow.execute())
//               .thenAnswer((_) async => Right(tTvShowList));
//           return tvShowPopularBloc;
//         },
//         act: (bloc) => bloc.add(const PopularTvShow()),
//         wait: const Duration(milliseconds: 1000),
//         expect: () => [TvShowLoading(), TvShowHashData(tTvShowList)]);
//
//     blocTest<TvShowTopRatedBloc, TvShowState>(
//         'Should emit [Loading, HasData] when data is gotten successfully',
//         build: () {
//           when(mockGetTopRatedTvShow.execute())
//               .thenAnswer((_) async => Right(tTvShowList));
//           return tvShowTopRatedBloc;
//         },
//         act: (bloc) => bloc.add(const TopRatedTvShow()),
//         wait: const Duration(milliseconds: 1000),
//         expect: () => [TvShowLoading(), TvShowHashData(tTvShowList)]);
//   });
// }
