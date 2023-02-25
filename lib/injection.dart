import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie/movie_local_data_source.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';
import 'package:core/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:core/data/datasources/tvshow/tvshow_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvshow_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';
import 'package:core/domain/usecases/tvshow/get_airing_today_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/search_tvshow.dart';
import 'package:core/presentation/bloc/movie/movie_add_watchlist.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_remove_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_detail_watchlist_status_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_watchlist_status_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_popular_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_add_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_remove_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_watchlist_bloc.dart';
import 'package:search/bloc/movie/search_bloc.dart';
import 'package:search/bloc/tvshow/search_tvshow_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvShowBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailWatchlistStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailWatchlistStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowAiringTodayBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(locator()),
  );

  locator.registerFactory(
    () => MovieAddWatchlistBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => MovieRemoveWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailRecommendationBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TvShowAddWatchlistBloc(
        locator()
    ),
  );
  locator.registerFactory(
        () => TvShowRemoveWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowDetailRecommendationBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetAiringTodayTvShow(locator()));
  locator.registerLazySingleton(() => GetPopularTvShow(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShow(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvShow(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShow(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
