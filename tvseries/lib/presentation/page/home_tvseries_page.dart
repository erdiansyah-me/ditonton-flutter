import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/tvseries_list/tvseries_list_cubit.dart';
import 'package:tvseries/presentation/page/popular_tvseries_page.dart';
import 'package:tvseries/presentation/page/top_rated_tvseries_page.dart';
import 'package:tvseries/presentation/page/tvseries_detail_page.dart';
import 'package:tvseries/presentation/page/tvseries_search_page.dart';

class HomeTvseriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tvseries';

  const HomeTvseriesPage({super.key});
  @override
  _HomeTvseriesPageState createState() => _HomeTvseriesPageState();
}

class _HomeTvseriesPageState extends State<HomeTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvseriesListCubit>().fetchListSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvseriesSearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On The Air',
                style: kHeading6,
              ),
              BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                if (state is ListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListHasData) {
                  return TvseriesList(state.onTheAirSeriesResult);
                } else if (state is ListError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvseriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                if (state is ListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListHasData) {
                  return TvseriesList(state.popularSeriesResult);
                } else if (state is ListError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvseriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                if (state is ListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListHasData) {
                  return TvseriesList(state.topRatedSeriesResult);
                } else if (state is ListError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
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
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvseriesList extends StatelessWidget {
  final List<Tvseries> tvseries;

  const TvseriesList(this.tvseries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvseriesDetailPage.ROUTE_NAME,
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
        itemCount: tvseries.length,
      ),
    );
  }
}
