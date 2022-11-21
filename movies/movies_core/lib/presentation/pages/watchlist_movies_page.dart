import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_core/movies_core.dart';
import 'package:movies_core/presentation/bloc/watchlist_movies_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMoviesBloc>().add(FetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state.watchlistMovies.isEmpty) {
              if (state.status == WatchlistMoviesStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == WatchlistMoviesStatus.error) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }
              return const Center(
                key: Key('no_watchlist'),
                child: Text('No Watchlist Movies Added'),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.watchlistMovies[index];
                return MovieCard(movie);
              },
              itemCount: state.watchlistMovies.length,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
