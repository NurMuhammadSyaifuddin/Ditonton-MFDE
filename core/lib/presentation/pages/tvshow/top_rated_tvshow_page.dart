import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_top_rated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tvshow_card_list.dart';

class TopRatedTvShowPage extends StatefulWidget {

  const TopRatedTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedTvShowPageState createState() => _TopRatedTvShowPageState();
}

class _TopRatedTvShowPageState extends State<TopRatedTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvShowTopRatedBloc>().add(const TopRatedTvShow()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowTopRatedBloc, TvShowState>(
          builder: (context, state) {
            if (state is TvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowHashData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshowData = state.result[index];
                  return TvShowCard(tvshowData);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvShowError){
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
}
