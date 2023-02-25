import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_detail_watchlist_status_bloc.dart';
import 'package:core/presentation/bloc/tvshow/tvshow_remove_watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tvshow/tvshow_detail.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../bloc/tvshow/tvshow_add_watchlist.dart';
import '../../bloc/tvshow/tvshow_detail_recommendation_bloc.dart';
import '../../bloc/tvshow/tvshow_event.dart';
import '../../bloc/tvshow/tvshow_state.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvshow';

  final int id;

  const TvShowDetailPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(DetailTvShow(widget.id));
      context
          .read<TvShowDetailRecommendationBloc>()
          .add(RecommendationTvShow(widget.id));
      context
          .read<TvShowDetailWatchlistStatusBloc>()
          .add(WatchListDetailTvShowStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvShowDetailBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowDetailHashData) {
            final tvshow = state.result;
            return SafeArea(
              child: DetailContent(
                tvshow
              ),
            );
          }
            return Container();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvshow;

  const DetailContent(this.tvshow, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvshow.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final state = BlocProvider.of<
                                    TvShowDetailWatchlistStatusBloc>(
                                    context,
                                    listen: false)
                                    .state as TvShowDetailWatchlistStatus;

                                if (!state.result) {
                                  context
                                      .read<TvShowAddWatchlistBloc>()
                                      .add(AddTvShowWatchlist(tvshow));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Added to Watchlist')));
                                } else {
                                  context
                                      .read<TvShowRemoveWatchlistBloc>()
                                      .add(RemoveTvShowWatchlist(tvshow));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Removed from Watchlist')));
                                }
                                context
                                    .read<TvShowDetailWatchlistStatusBloc>()
                                    .add(WatchListDetailTvShowStatus(tvshow.id));
                              },
                              child: BlocBuilder<
                                  TvShowDetailWatchlistStatusBloc, TvShowState>(
                                builder: (context, state) {
                                  if (state is TvShowDetailWatchlistStatus) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.result
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              )
                            ),
                            Text(
                              _showGenres(tvshow.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvshow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvshow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvshow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowDetailRecommendationBloc, TvShowState>(
                              builder: (context, state) {
                                if (state is TvShowLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvShowError) {
                                  return Text(state.message);
                                } else if (state is TvShowHashData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvshowData =
                                            state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.ROUTE_NAME,
                                                arguments: tvshowData.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvshowData.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
