import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../styles/colors.dart';
import '../../../utils/state_enum.dart';
import '../../../utils/utils.dart';
import '../../provider/tvshow/watchlist_tvshow_notifier.dart';
import '../../widgets/tvshow_card_list.dart';

class WatchlistTvShow extends StatefulWidget {
  const WatchlistTvShow({super.key});


  @override
  _WatchlistTvShowState createState() => _WatchlistTvShowState();
}

class _WatchlistTvShowState extends State<WatchlistTvShow>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvShowNotifier>(context, listen: false)
        .fetchWatchlistTvShow();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Consumer<WatchlistTvShowNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              final dataWatchlist = data.watchlistTvShow;
              if (dataWatchlist.isEmpty) {
                return const Center(
                  child: Text('Data empty :)'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvShowCard(dataWatchlist[index]);
                },
                itemCount: data.watchlistTvShow.length,
              );
            } else {
              return Center(
                // ignore: prefer_const_constructors
                key: Key('error_message'),
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
