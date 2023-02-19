import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../provider/tvshow/airing_today_tvshow_notifier.dart';
import '../../widgets/tvshow_card_list.dart';

class AiringTodayTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tvshow';

  const AiringTodayTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AiringTodayTvShowPageState createState() => _AiringTodayTvShowPageState();
}

class _AiringTodayTvShowPageState extends State<AiringTodayTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringTodayTvShowNotifier>(context, listen: false)
            .fetchAiringTodayTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTvShowNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = data.tvshow[index];
                  return TvShowCard(tvshow);
                },
                itemCount: data.tvshow.length,
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
}
