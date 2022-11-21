import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/series_core.dart';
import 'package:series_search/series_search.dart';

class SearchSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-series';

  const SearchSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Series"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) =>
                  context.read<SearchSeriesBloc>().add(OnQueryChanged(query)),
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
            BlocBuilder<SearchSeriesBloc, SearchSeriesState>(
              builder: (context, state) {
                if (state.searchResult.isEmpty) {
                  if (state.status == SeriesBlocState.loading) {
                    return const Center(
                      key: Key('Series Loading'),
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == SeriesBlocState.error) {
                    return Expanded(
                      child: Center(
                        key: const Key('Error Message'),
                        child: Text(state.message),
                      ),
                    );
                  }

                  return const Expanded(
                    child: Center(
                      child: Text('No Series Found!'),
                    ),
                  );
                }
                final result = state.searchResult;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final series = state.searchResult[index];
                      return SeriesCard(series: series);
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
