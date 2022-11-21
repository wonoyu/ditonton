import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series_core/series_core.dart';
import 'package:series_detail/series_detail.dart';

class HomeSeriesPage extends StatefulWidget {
  const HomeSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeSeriesPage> createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnTheAirSeriesBloc>().add(const FetchOnTheAirSeries());
    context.read<PopularSeriesBloc>().add(const FetchPopularSeries());
    context.read<TopRatedSeriesBloc>().add(const FetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeading(
          title: 'On The Air (Now Playing)',
          onTap: () =>
              Navigator.pushNamed(context, OnTheAirSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<OnTheAirSeriesBloc, OnTheAirSeriesState>(
          builder: (context, state) {
            if (state.series.isEmpty) {
              if (state.status == SeriesBlocState.loading) {
                return const Center(
                  key: Key('Loading Now Playing'),
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == SeriesBlocState.error) {
                return Text(
                  state.message,
                  key: const Key('Error On The Air'),
                );
              }
            }
            return SeriesList(state.series);
          },
        ),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state.series.isEmpty) {
              if (state.status == SeriesBlocState.loading) {
                return const Center(
                  key: Key('Loading Popular'),
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == SeriesBlocState.error) {
                return Text(
                  state.message,
                  key: const Key('Error Popular'),
                );
              }
            }
            return SeriesList(state.series);
          },
        ),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
        ),
        BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state.series.isEmpty) {
              if (state.status == SeriesBlocState.loading) {
                return const Center(
                  key: Key('Loading Top Rated'),
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == SeriesBlocState.error) {
                return Text(
                  state.message,
                  key: const Key('Error Top Rated'),
                );
              }
            }
            return SeriesList(state.series);
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> listSeries;

  const SeriesList(this.listSeries);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = listSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: listSeries.length,
      ),
    );
  }
}
