import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../provider/tvshow/top_rated_tvshow_notifier.dart';
import '../../widgets/tvshow_card_list.dart';

class TopRatedTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvshow';

  const TopRatedTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedTvShowPageState createState() => _TopRatedTvShowPageState();
}

class _TopRatedTvShowPageState extends State<TopRatedTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvShowNotifier>(context, listen: false)
            .fetchTopRatedTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvShowNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshowData = data.tvshow[index];
                  return TvShowCard(tvshowData);
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
