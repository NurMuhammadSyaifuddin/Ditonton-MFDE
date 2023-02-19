import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/tvshow/tvshow.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../../utils/state_enum.dart';
import '../../provider/tvshow/tvshow_list_notifier.dart';
import '../../widgets/bottom_nav_bar.dart';

class HomeTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tvshow';

  const HomeTvShowPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchAiringTodayTvShow()
          ..fetchPopularTvShow()
          ..fetchTopRatedTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selected: TypeBottomNav.tvshow),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TVSHOW_ROUTE);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, ABOUT_ROUTE);
          }, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () =>
                    Navigator.pushNamed(context, AIRING_TODAY_TVSHOW_ROUTE),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.airingTodayTvShow);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TVSHOW_ROUTE),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularTvShowState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.popularTvShow);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_TVSHOW_ROUTE),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvShowState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.topRatedTvShow);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvshow;

  const TvShowList(this.tvshow, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvshowData = tvshow[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tvshowData.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvshowData.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvshow.length,
      ),
    );
  }
}
