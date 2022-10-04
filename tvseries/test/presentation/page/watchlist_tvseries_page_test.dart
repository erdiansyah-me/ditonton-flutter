import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/page/watchlist_tvseries_page.dart';
import 'package:tvseries/presentation/provider/watchlist_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'watchlist_tvseries_page_test.mocks.dart';


@GenerateMocks([WatchlistTvseriesNotifier])
void main() {
  late MockWatchlistTvseriesNotifier mockProvider;

  setUp((){
    mockProvider = MockWatchlistTvseriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvseriesNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('popular tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(mockProvider.seriesWatchlistState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(mockProvider.seriesWatchlistState).thenReturn(RequestState.Loaded);
      when(mockProvider.seriesWatchlist).thenReturn(<Tvseries>[]);

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(mockProvider.seriesWatchlistState).thenReturn(RequestState.Error);
      when(mockProvider.message).thenReturn('Error message');

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}