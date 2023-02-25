import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/colors.dart';
import '../../../utils/utils.dart';
import '../../bloc/tvshow/tvshow_event.dart';
import '../../widgets/tvshow_card_list.dart';

class WatchlistTvShow extends StatefulWidget {
  const WatchlistTvShow({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _WatchlistTvShowState createState() => _WatchlistTvShowState();
}

class _WatchlistTvShowState extends State<WatchlistTvShow>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvShowWatchlistBloc>().add(const TvShowWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvShowWatchlistBloc>().add(const TvShowWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: BlocBuilder<TvShowWatchlistBloc, TvShowState>(
          builder: (context, state) {
            if (state is TvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowHashData) {
              final dataWatchlist = state.result;
              if (dataWatchlist.isEmpty) {
                return const Center(
                  child: Text('Data empty :)'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvShowCard(dataWatchlist[index]);
                },
                itemCount: dataWatchlist.length,
              );
            } else if (state is TvShowError){
              return Center(
                // ignore: prefer_const_constructors
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
            return Container();
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
