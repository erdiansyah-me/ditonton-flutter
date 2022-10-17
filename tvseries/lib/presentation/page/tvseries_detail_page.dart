import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/domain/entities/Tvseries_detail.dart';
import 'package:tvseries/domain/entities/genre.dart';
import 'package:tvseries/presentation/bloc/cubit/tvseries_detail/tvseries_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvseriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  TvseriesDetailPage({required this.id});

  @override
  _TvseriesDetailPageState createState() => _TvseriesDetailPageState();
}

class _TvseriesDetailPageState extends State<TvseriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvseriesDetailCubit>().fetchTvseriesDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvseriesDetailCubit, TvseriesDetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailHasData) {
            final series = state.tvseriesDetail;
            return SafeArea(
              child: DetailContent(
                series,
                state.recommendationDetail,
                state.isAddedtoSeriesWatchlist,
              ),
            );
          } else if (state is DetailError) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvseriesDetail series;
  final List<Tvseries> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.series, this.recommendations, this.isAddedWatchlist, {super.key});

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
                              series.name ?? '-',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await context.read<TvseriesDetailCubit>()
                                      .addSeriesWatchlist(series);
                                } else {
                                  await context.read<TvseriesDetailCubit>()
                                      .removeSeriesWatchlist(series);
                                }

                                final message =
                                    context.read<TvseriesDetailCubit>()
                                        .message;

                                if (message ==
                                        TvseriesDetailCubit
                                            .seriesWatchlistAddSuccessMessage ||
                                    message ==
                                        TvseriesDetailCubit
                                            .seriesWatchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
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
                            ),
                            Text(
                              _showGenres(series.genres ?? []),
                            ),
                            Text('${series.numberOfEpisodes} Episodes '),
                            Text('${series.numberOfSeasons} Seasons '),
                            Text('First Air Date: ${series.firstAirDate}'),
                            Text('Last Air Date: ${series.lastAirDate}'),
                            Text(series.status ?? '-'),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage ?? 2 / 2 ,
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
                              series.overview ?? '-',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvseriesDetailCubit, TvseriesDetailState>(
                              builder: (context, state) {
                                if (state is DetailLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is DetailError) {
                                  return Text(state.message);
                                } else if (state is DetailHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final series = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvseriesDetailPage.ROUTE_NAME,
                                                arguments: series.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
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
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
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
