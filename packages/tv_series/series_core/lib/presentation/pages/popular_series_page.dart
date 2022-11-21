import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series_core/series_core.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = "/popular-series";

  const PopularSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularSeriesPage> createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularSeriesBloc>().add(const FetchPopularSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
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
