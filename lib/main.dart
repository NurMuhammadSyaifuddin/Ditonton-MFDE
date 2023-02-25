import 'dart:io';
import 'dart:typed_data';

import 'package:about/about_page.dart';
import 'package:core/presentation/bloc/movie/movie_add_watchlist.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_detail_watchlist_status_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_remove_watchlist.dart';
import 'package:core/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_add_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_watchlist_status_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_popular_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_remove_watchlist.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_watchlist_bloc.dart';
import 'package:core/presentation/pages/movie/home_movie_page.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/presentation/pages/movie/now_playing_movies_page.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/movie/search_bloc.dart';
import 'package:search/bloc/tvshow/search_tvshow_bloc.dart';
import 'package:search/presentation/pages/movie/search_page.dart';
import 'package:core/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tvshow/airing_today_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/home_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/popular_tvshow_page.dart';
import 'package:search/presentation/pages/tvshow/search_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/top_rated_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:core/presentation/pages/watchlist/watchlist_page.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set SecurityContext to not trust the OS's certificates
  SecurityContext(withTrustedRoots: false);
  // Load certificate file
  ByteData data = await rootBundle.load('assets/certificates.crt');
  SecurityContext context = SecurityContext.defaultContext;
  // Trust the certificate
  context.setTrustedCertificatesBytes(data.buffer.asUint8List());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<SearchBloc>(),),
        BlocProvider(create: (_) => di.locator<SearchTvShowBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieNowPlayingBloc>(),),
        BlocProvider(create: (_) => di.locator<MoviePopularBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieTopRatedBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowAiringTodayBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowPopularBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowTopRatedBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieDetailRecommendationBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieDetailWatchlistStatusBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieAddWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<MovieRemoveWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowAddWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowRemoveWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowDetailRecommendationBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowWatchlistBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowDetailBloc>(),),
        BlocProvider(create: (_) => di.locator<TvShowDetailWatchlistStatusBloc>(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HOME_TVSHOW_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeTvShowPage());
            case NOW_PLAYING_ROUTE:
              return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case AIRING_TODAY_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => AiringTodayTvShowPage());
            case POPULAR_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvShowPage());
            case TOP_RATED_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVSHOW_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SEARCH_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvShowPage());
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
