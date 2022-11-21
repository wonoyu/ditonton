import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/presentation/bloc/save_watchlist_series_bloc.dart';
import 'package:series_detail/presentation/bloc/series_detail_bloc.dart';
import 'package:series_detail/presentation/bloc/series_recommendations_bloc.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detailSeries';

  const SeriesDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeriesDetailBloc>().add(FetchSeriesDetail(widget.id));
    context
        .read<SeriesRecommendationsBloc>()
        .add(FetchSeriesRecommendations(widget.id));
    context
        .read<SaveWatchlistSeriesBloc>()
        .add(LoadWatchlistSeriesStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state.status == SeriesBlocState.loaded) {
            final movie = state.series!;
            return SafeArea(
              child: DetailContent(
                movie,
              ),
            );
          }
          if (state.status == SeriesBlocState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            key: const Key('Error Message'),
            child: Text(state.message),
          );
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail series;

  const DetailContent(this.series);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            BlocListener<SaveWatchlistSeriesBloc,
                                SaveWatchlistSeriesState>(
                              listener: (context, state) {
                                if (state.message == state.errorMessage &&
                                    state.status == SeriesBlocState.error) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(state.message),
                                        );
                                      });
                                }
                                if (state.message == state.successMessage &&
                                    state.status == SeriesBlocState.loaded) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                }
                              },
                              child: BlocBuilder<SaveWatchlistSeriesBloc,
                                  SaveWatchlistSeriesState>(
                                builder: (context, state) {
                                  final isAddedWatchlist =
                                      state.isAddedToWatchlist;
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedWatchlist) {
                                        context
                                            .read<SaveWatchlistSeriesBloc>()
                                            .add(AddToWatchlistSeries(series));
                                      } else {
                                        context
                                            .read<SaveWatchlistSeriesBloc>()
                                            .add(RemoveFromWatchlistSeries(
                                                series));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Text(
                              _showGenres(series.genres),
                            ),
                            Text(
                              "${series.numberOfEpisodes} Episode(s), ${series.numberOfSeasons} Season(s)",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationsBloc,
                                SeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state.series.isEmpty) {
                                  if (state.status == SeriesBlocState.loading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state.status == SeriesBlocState.error) {
                                    return Center(
                                      child: Text(
                                        state.message,
                                        key: const Key('Error Message'),
                                      ),
                                    );
                                  }
                                }
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final series = state.series[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              SeriesDetailPage.ROUTE_NAME,
                                              arguments: series.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.series.length,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = series.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, SeasonDetailPage.ROUTE_NAME,
                                          arguments: season),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: season.posterPath == null
                                            ? const Text("Image Not Available")
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: series.seasons.length,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Last Episode To Air",
                              style: kHeading6,
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            if (series.lastEpisodeToAir != null)
                              EpisodeToAirWidget(
                                episode: series.lastEpisodeToAir!,
                              ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Next Episode To Air",
                              style: kHeading6,
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            if (series.nextEpisodeToAir != null)
                              EpisodeToAirWidget(
                                episode: series.nextEpisodeToAir!,
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class EpisodeToAirWidget extends StatelessWidget {
  const EpisodeToAirWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final EpisodeToAir episode;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        episode.stillPath == null
            ? const SizedBox(
                height: 100,
                child: Center(child: Text("Image Not Available")),
              )
            : ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                  width: screenWidth,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
        Text(
          episode.name,
          style: kHeading5,
        ),
        Text(
          "Episode : ${episode.episodeNumber}, Season : ${episode.seasonNumber}",
        ),
        Text("Air Date : ${episode.airDate}"),
        Row(
          children: [
            RatingBarIndicator(
              rating: episode.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${episode.voteAverage}')
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(
          episode.overview,
        ),
      ],
    );
  }
}
