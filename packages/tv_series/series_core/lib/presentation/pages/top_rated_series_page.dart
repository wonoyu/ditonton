import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series_core/presentation/bloc/top_rated_series_bloc.dart';
import 'package:series_core/series_core.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  const TopRatedSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedSeriesPage> createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedSeriesBloc>().add(const FetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state.series.isEmpty) {
              if (state.status == SeriesBlocState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == SeriesBlocState.error) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final series = state.series[index];
                return SeriesCard(series: series);
              },
              itemCount: state.series.length,
            );
          },
        ),
      ),
    );
  }
}
