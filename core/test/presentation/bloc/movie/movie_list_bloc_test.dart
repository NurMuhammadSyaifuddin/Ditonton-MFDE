import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/movie_event.dart';
import 'package:core/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_state.dart';
import 'package:core/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MoviePopularBloc moviePopularBloc;
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('Movie', () {
    blocTest<MovieNowPlayingBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return movieNowPlayingBloc;
        },
        act: (bloc) => bloc.add(const NowPlayingMovies()),
        wait: const Duration(milliseconds: 1000),
        expect: () => [MovieLoading(), MovieHashData(tMovieList)]);

    blocTest<MoviePopularBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(const PopularMovies()),
        wait: const Duration(milliseconds: 1000),
        expect: () => [MovieLoading(), MovieHashData(tMovieList)]);

    blocTest<MovieTopRatedBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(const TopRatedMovies()),
        wait: const Duration(milliseconds: 1000),
        expect: () => [MovieLoading(), MovieHashData(tMovieList)]);
  });


}
