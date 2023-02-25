import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_popular_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tvshow_card_list.dart';

class PopularTvShowPage extends StatefulWidget {

  const PopularTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopularTvShowPageState createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvShowPopularBloc>().add(const PopularTvShow()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowPopularBloc, TvShowState>(
          builder: (context, state) {
            if (state is TvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowHashData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshowData = state.result[index];
                  return  TvShowCard(tvshowData);
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
