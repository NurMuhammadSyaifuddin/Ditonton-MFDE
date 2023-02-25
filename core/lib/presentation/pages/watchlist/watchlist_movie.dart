import 'package:core/presentation/bloc/movie/movie_event.dart';
import 'package:core/presentation/bloc/movie/movie_state.dart';
import 'package:core/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/colors.dart';
import '../../../utils/utils.dart';
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
        context.read<MovieWatchlistBloc>().add(const WatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(const WatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: BlocBuilder<MovieWatchlistBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieHashData) {
              final dataWatchlist = state.result;
              if (dataWatchlist.isEmpty) {
                return const Center(
                  child: Text('Data empty :)'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(dataWatchlist[index]);
                },
                itemCount: dataWatchlist.length,
              );
            } else if (state is MovieError){
              return Center(
                key: const Key('error_message'),
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
