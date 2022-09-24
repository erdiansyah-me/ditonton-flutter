import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tvseries_page_test.mocks.dart';

@GenerateMocks([TopRatedSeriesNotifier])
void main() {
  late MockTopRatedSeriesNotifier mockProvider;

  setUp((){
    mockProvider = MockTopRatedSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedSeriesNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('TopRated tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(<Tvseries>[]);

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Error);
      when(mockProvider.message).thenReturn('Error message');

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}