import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';
import 'tvseries_detail_page_test.mocks.dart';

@GenerateMocks([TvseriesDetailNotifier])
void main() {
  late MockTvseriesDetailNotifier mockProvider;

  setUp(() {
    mockProvider = MockTvseriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvseriesDetailNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('tvseries detail page', () {
    testWidgets('watchlist button should display add icon when tvseries not added to watchlist',
      (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Loaded);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(false);

      final watchlistButton = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

      expect(watchlistButton, findsOneWidget);
    });

    testWidgets('watchlist button should display check icon when tvseries added to watchlist',
        (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Loaded);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(true);

      final watchlistButton = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

      expect(watchlistButton, findsOneWidget);
    });

    testWidgets('watchlist button should display snackbar when tvseries added to watchlist',
        (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Loaded);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(false);
      when(mockProvider.seriesWatchlistMessage).thenReturn('Added to Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

      expect(watchlistButton, findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets('watchlist button should display alertDialog when tvseries added to watchlist failed',
        (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Loaded);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(false);
      when(mockProvider.seriesWatchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('should display loading progress when recommendation state loading',
        (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Loading);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(true);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    });
    testWidgets('should display container progress when recommendation state empty',
        (WidgetTester tester) async {
      when(mockProvider.seriesState).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(testTvseriesDetail);
      when(mockProvider.seriesRecommendationState).thenReturn(RequestState.Empty);
      when(mockProvider.seriesRecommendation).thenReturn(<Tvseries>[]);
      when(mockProvider.isAddedtoSeriesWatchlist).thenReturn(true);

      final containerFinder = find.byType(Container);

      await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));
      expect(containerFinder, findsWidgets);
    });
  });
}