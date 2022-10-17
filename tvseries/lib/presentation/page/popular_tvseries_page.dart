
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/cubit/popular_tvseries/popular_tvseries_cubit.dart';
import 'package:tvseries/presentation/widget/tvseries_card_list.dart';
import 'package:flutter/material.dart';

class PopularTvseriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  @override
  _PopularTvseriesPageState createState() => _PopularTvseriesPageState();
}

class _PopularTvseriesPageState extends State<PopularTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<PopularTvseriesCubit>().fetchPopularSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvseriesCubit, PopularTvseriesState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.result[index];
                  return TvseriesCard(series);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
