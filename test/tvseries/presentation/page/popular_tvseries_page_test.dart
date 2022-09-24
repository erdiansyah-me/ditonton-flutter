import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/Tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:ditonton/presentation/provider/tvseries/popular_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tvseries_page_test.mocks.dart';

@GenerateMocks([PopularSeriesNotifier])
void main() {
  late MockPopularSeriesNotifier mockProvider;

  setUp((){
    mockProvider = MockPopularSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularSeriesNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('popular tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loaded);
      when(mockProvider.series).thenReturn(<Tvseries>[]);

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Error);
      when(mockProvider.message).thenReturn('Error message');

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}