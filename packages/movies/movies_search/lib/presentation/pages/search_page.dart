import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_search/presentation/bloc/movies_search_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) =>
                  context.read<MoviesSearchBloc>().add(OnQueryChanged(query)),
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
              builder: (context, state) {
                if (state.searchResult.isEmpty) {
                  if (state.status == MoviesSearchStatus.loading) {
                    return const Center(
                      key: Key('Movies Loading'),
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == MoviesSearchStatus.error) {
                    return Expanded(
                      child: Center(
                        key: const Key('Error Message'),
                        child: Text(state.message),
                      ),
                    );
                  }

                  return const Expanded(
                    child: Center(
                      child: Text('No Movies Found!'),
                    ),
                  );
                }
                final result = state.searchResult;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = state.searchResult[index];
                      return MovieCard(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
