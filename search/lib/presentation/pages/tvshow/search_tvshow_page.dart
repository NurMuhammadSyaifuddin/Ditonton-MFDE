import 'package:core/presentation/widgets/tvshow_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/tvshow/search_tvshow_bloc.dart';
import 'package:search/bloc/tvshow/search_tvshow_event.dart';
import 'package:search/bloc/tvshow/search_tvshow_state.dart';

class SearchTvShowPage extends StatelessWidget {
  const SearchTvShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvShowBloc>().add(OnQueryTvShowChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvShowBloc, SearchTvShowState>(
                builder: (context, state) {
              if (state is SearchTvShowLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvShowHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tvshowData = result[index];
                      return TvShowCard(tvshowData);
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
