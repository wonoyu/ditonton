import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:series_core/series_core.dart';

class SeasonDetailPage extends StatelessWidget {
  static const ROUTE_NAME = "/season-detail";

  const SeasonDetailPage({Key? key, required this.season}) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
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
                                  season.name ?? "",
                                  style: kHeading5,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Season : ${season.seasonNumber}, ${season.episodeCount} Episode(s)",
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text("Air Date : ${season.airDate}"),
                                const SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style: kHeading6,
                                ),
                                Text(
                                  season.overview ?? "",
                                ),
                                const SizedBox(
                                  height: 16.0,
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
                initialChildSize: 0.35,
                minChildSize: 0.30,
                maxChildSize: 0.6,
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
        ),
      ),
    );
  }
}
