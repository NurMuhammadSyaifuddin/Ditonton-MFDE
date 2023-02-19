import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../provider/tvshow/popular_tvshow_notifier.dart';
import '../../widgets/tvshow_card_list.dart';

class PopularTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvshow';

  const PopularTvShowPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopularTvShowPageState createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvShowNotifier>(context, listen: false)
            .fetchPopularTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvShowNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshowData = data.tvshow[index];
                  return  TvShowCard(tvshowData);
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
