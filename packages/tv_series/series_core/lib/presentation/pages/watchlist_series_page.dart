import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/series_core.dart';

class WatchlistSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-series';

  const WatchlistSeriesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistSeriesPage> createState() => _WatchlistSeriesPageState();
}

class _WatchlistSeriesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistSeriesBloc>().add(const FetchWatchlistSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistSeriesBloc>().add(const FetchWatchlistSeries());
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
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
              return const Center(
                key: Key('no_watchlist'),
                child: Text('No Watchlist Series Added'),
              );
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
