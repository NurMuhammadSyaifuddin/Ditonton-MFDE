import 'package:core/presentation/bloc/tvshow/tvshow_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_event.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tvshow_card_list.dart';

class AiringTodayTvShowPage extends StatefulWidget {

  const AiringTodayTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AiringTodayTvShowPageState createState() => _AiringTodayTvShowPageState();
}

class _AiringTodayTvShowPageState extends State<AiringTodayTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvShowAiringTodayBloc>().add(const AiringTodayTvShow()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowAiringTodayBloc, TvShowState>(
          builder: (context, state) {
            if (state is TvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowHashData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = state.result[index];
                  return TvShowCard(tvshow);
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
