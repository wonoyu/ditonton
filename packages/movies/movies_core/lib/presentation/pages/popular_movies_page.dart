import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_core/movies_core.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMoviesBloc>().add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state.movies.isEmpty) {
              if (state.status == MovieListStatus.error) {
                return Text(
                  state.message,
                  key: const Key('error_message'),
                );
              }
              if (state.status == MovieListStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                });
          },
        ),
      ),
    );
  }
}
