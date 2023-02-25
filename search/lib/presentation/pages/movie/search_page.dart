import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import 'package:core/core.dart';
import 'package:search/bloc/movie/search_event.dart';

import '../../../bloc/movie/search_bloc.dart';
import '../../../bloc/movie/search_state.dart';

class SearchPage extends StatelessWidget {

  const SearchPage({super.key});

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
              onChanged: (query) {
                context.read<SearchBloc>().add(OnQueryChanged(query));
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
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state){
              // ignore: unrelated_type_equality_checks
              if (state is SearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              // ignore: unrelated_type_equality_checks
              } else if (state is SearchHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return MovieCard(movie);
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
