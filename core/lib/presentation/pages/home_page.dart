import 'package:core/core.dart';
import 'package:core/presentation/bloc/change_list_to_show_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeListToShowBloc, ChangeListToShowState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/circle-g.png'),
                  ),
                  accountName: Text('Ditonton'),
                  accountEmail: Text('ditonton@dicoding.com'),
                ),
                ListTile(
                  leading: const Icon(Icons.movie),
                  selected: state.isMovies,
                  title: const Text('Movies'),
                  onTap: () {
                    if (state.isMovies) {
                      Navigator.pop(context);
                      return;
                    }
                    context.read<ChangeListToShowBloc>().add(ChangeList());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Changed to Movies'),
                      ),
                    );

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.live_tv_outlined),
                  selected: !state.isMovies,
                  title: const Text('TV Series'),
                  onTap: () {
                    if (!state.isMovies) {
                      Navigator.pop(context);
                      return;
                    }
                    context.read<ChangeListToShowBloc>().add(ChangeList());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Changed to TV Series'),
                      ),
                    );

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.save_alt),
                  title: const Text('Watchlist'),
                  onTap: () {
                    if (state.isMovies) {
                      Navigator.pushNamed(
                          context, WatchlistMoviesPage.ROUTE_NAME);
                      return;
                    }
                    Navigator.pushNamed(
                        context, WatchlistSeriesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title:
                Text(state.isMovies ? 'Ditonton Movies' : 'Ditonton TV Series'),
            actions: [
              IconButton(
                onPressed: () {
                  if (state.isMovies) {
                    Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                    return;
                  }
                  Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: state.isMovies ? HomeMoviePage() : const HomeSeriesPage(),
            ),
          ),
        );
      },
    );
  }
}
