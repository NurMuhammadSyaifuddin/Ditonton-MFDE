// import 'package:bloc_test/bloc_test.dart';
// import 'package:core/domain/entities/genre.dart';
// import 'package:core/domain/entities/movie/movie.dart';
// import 'package:core/domain/entities/movie/movie_detail.dart';
// import 'package:core/domain/usecases/movie/get_movie_detail.dart';
// import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
// import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
// import 'package:core/domain/usecases/movie/remove_watchlist.dart';
// import 'package:core/domain/usecases/movie/save_watchlist.dart';
// import 'package:core/presentation/bloc/movie/movie_add_watchlist.dart';
// import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
// import 'package:core/presentation/bloc/movie/movie_detail_recommendation_bloc.dart';
// import 'package:core/presentation/bloc/movie/movie_event.dart';
// import 'package:core/presentation/bloc/movie/movie_remove_watchlist.dart';
// import 'package:core/presentation/bloc/movie/movie_state.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'movie_detail_bloc_test.mocks.dart';
//
// @GenerateMocks([
//   GetMovieDetail,
//   GetMovieRecommendations,
//   GetWatchListStatus,
//   SaveWatchlist,
//   RemoveWatchlist,
// ])
// void main() {
//   late MovieDetailBloc movieDetailBloc;
//   late MovieAddWatchlistBloc movieAddWatchlistBloc;
//   late MovieRemoveWatchlistBloc movieRemoveWatchlistBloc;
//   late MovieDetailRecommendationBloc movieDetailRecommendationBloc;
//   late MockGetMovieDetail mockGetMovieDetail;
//   late MockGetMovieRecommendations mockGetMovieRecommendations;
//   late MockSaveWatchlist mockSaveWatchlist;
//   late MockRemoveWatchlist mockRemoveWatchlist;
//
//   setUp(() {
//     mockGetMovieDetail = MockGetMovieDetail();
//     mockGetMovieRecommendations = MockGetMovieRecommendations();
//     mockSaveWatchlist = MockSaveWatchlist();
//     mockRemoveWatchlist = MockRemoveWatchlist();
//     movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
//     movieDetailRecommendationBloc = MovieDetailRecommendationBloc(mockGetMovieRecommendations);
//     movieAddWatchlistBloc = MovieAddWatchlistBloc(mockSaveWatchlist);
//     movieRemoveWatchlistBloc = MovieRemoveWatchlistBloc(mockRemoveWatchlist);
//   });
//
//   const tId = 1;
//
//   final tMovieDetail = MovieDetail(
//     adult: false,
//     backdropPath: 'backdropPath',
//     genres: [Genre(id: 1, name: 'name')],
//     id: 1,
//     originalTitle: 'originalTitle',
//     overview: 'overview',
//     posterPath: 'posterPath',
//     releaseDate: 'releaseDate',
//     title: 'title',
//     voteAverage: 1,
//     voteCount: 1,
//     runtime: 1,
//   );
//
//   final tMovie = Movie(
//     adult: false,
//     backdropPath: 'backdropPath',
//     id: 1,
//     originalTitle: 'originalTitle',
//     overview: 'overview',
//     posterPath: 'posterPath',
//     releaseDate: 'releaseDate',
//     title: 'title',
//     voteAverage: 1,
//     voteCount: 1,genreIds: const [1, 2, 3], popularity: 10, video: true,
//   );
//
//
//
//   group('Get Movie Detail', ()
//   {
//     blocTest<MovieDetailBloc, MovieState>(
//         'Should emit [Loading, HasData] when data is gotten successfully',
//         build: () {
//           when(mockGetMovieDetail.execute(tId))
//               .thenAnswer((_) async => Right(tMovieDetail));
//           return movieDetailBloc;
//         },
//         act: (bloc) => bloc.add(const DetailMovie(tId)),
//         wait: const Duration(milliseconds: 1000),
//         expect: () =>
//         [
//           MovieLoading(),
//           MovieDetailHashData(tMovieDetail)
//         ]);
//
//     blocTest<MovieDetailRecommendationBloc, MovieState>(
//         'Should emit [Loading, HasData] when data is gotten successfully',
//         build: () {
//           when(mockGetMovieRecommendations.execute(tId))
//               .thenAnswer((_) async => Right([tMovie]));
//           return movieDetailRecommendationBloc;
//         },
//         act: (bloc) => bloc.add(const RecommendationMovie(tId)),
//         wait: const Duration(milliseconds: 1000),
//         expect: () =>
//         [
//           MovieLoading(),
//           MovieHashData([tMovie])
//         ]);
//
//
//     group('Watchlist', () {
//       blocTest<MovieAddWatchlistBloc, MovieState>(
//           'Should emit [Loading, HasData] when data is gotten successfully',
//           build: () {
//             when(mockSaveWatchlist.execute(tMovieDetail))
//                 .thenAnswer((_) async => const Right('Added to watchlist'));
//             return movieAddWatchlistBloc;
//           },
//           act: (bloc) => bloc.add(AddMovieWatchlist(tMovieDetail)),
//           wait: const Duration(milliseconds: 1000),
//           expect: () =>
//           [
//             MovieLoading(),
//             const MovieHashDataString('Added to watchlist'),
//           ]);
//
//       blocTest<MovieRemoveWatchlistBloc, MovieState>(
//           'Should emit [Loading, HasData] when data is gotten successfully',
//           build: () {
//             when(mockRemoveWatchlist.execute(tMovieDetail))
//                 .thenAnswer((_) async => const Right('Remove from watchlist'));
//             return movieRemoveWatchlistBloc;
//           },
//           act: (bloc) => bloc.add(RemoveMovieWatchlist(tMovieDetail)),
//           wait: const Duration(milliseconds: 1000),
//           expect: () =>
//           [
//             MovieLoading(),
//             const MovieHashDataString('Remove from watchlist')
//           ]);
//
//     });
//   });
// }
