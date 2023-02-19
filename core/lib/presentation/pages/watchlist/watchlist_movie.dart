import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../styles/colors.dart';
import '../../../utils/state_enum.dart';
import '../../../utils/utils.dart';
import '../../provider/movie/watchlist_movie_notifier.dart';
import '../../widgets/movie_card_list.dart';

class WatchlistMovie extends StatefulWidget {
  const WatchlistMovie({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistMovieState createState() => _WatchlistMovieState();
}

class _WatchlistMovieState extends State<WatchlistMovie> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              final dataWatchlist = data.watchlistMovies;
              if (dataWatchlist.isEmpty) {
                return const Center(
                  child: Text('Data empty :)'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(dataWatchlist[index]);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
