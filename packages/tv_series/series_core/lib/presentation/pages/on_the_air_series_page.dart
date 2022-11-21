import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series_core/series_core.dart';

class OnTheAirSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-series-page';

  const OnTheAirSeriesPage({Key? key}) : super(key: key);

  @override
  State<OnTheAirSeriesPage> createState() => _OnTheAirSeriesPageState();
}

class _OnTheAirSeriesPageState extends State<OnTheAirSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirSeriesBloc>().add(const FetchOnTheAirSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirSeriesBloc, OnTheAirSeriesState>(
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
