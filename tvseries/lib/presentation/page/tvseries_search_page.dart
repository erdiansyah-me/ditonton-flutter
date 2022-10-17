import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:tvseries/presentation/widget/tvseries_card_list.dart';
import 'package:flutter/material.dart';

class TvseriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/tvseries-search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvseriesSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvseriesSearchBloc, TvseriesSearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final series = result[index];
                        return TvseriesCard(series);
                      },//
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}