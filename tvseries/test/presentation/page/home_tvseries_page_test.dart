import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/page/home_tvseries_page.dart';
import 'package:tvseries/presentation/provider/tvseries_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_tvseries_page_test.mocks.dart';


@GenerateMocks([TvseriesListNotifier])
void main() {
  late MockTvseriesListNotifier mockProvider;

  setUp(() {
    mockProvider = MockTvseriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvseriesListNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('tvseries list page', () {
    testWidgets('should display loading progress when data loading',
        ((WidgetTester tester) async {
      when(mockProvider.onTheAirState).thenReturn(RequestState.Loading);
      when(mockProvider.popularState).thenReturn(RequestState.Loading);
      when(mockProvider.topRatedState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(HomeTvseriesPage()));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    }));

    testWidgets('should display listview when data loaded',
        ((WidgetTester tester) async {
      when(mockProvider.onTheAirState).thenReturn(RequestState.Loaded);
      when(mockProvider.onTheAirSeries).thenReturn(<Tvseries>[]);
      when(mockProvider.popularState).thenReturn(RequestState.Loaded);
      when(mockProvider.popularSeries).thenReturn(<Tvseries>[]);
      when(mockProvider.topRatedState).thenReturn(RequestState.Loaded);
      when(mockProvider.topRatedSeries).thenReturn(<Tvseries>[]);

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(HomeTvseriesPage()));
      
      expect(listviewFinder, findsNWidgets(3));
    }));

    testWidgets('should display error message when data Error',
        ((WidgetTester tester) async {
      when(mockProvider.onTheAirState).thenReturn(RequestState.Error);
      when(mockProvider.popularState).thenReturn(RequestState.Error);
      when(mockProvider.topRatedState).thenReturn(RequestState.Error);
      when(mockProvider.message).thenReturn('Failed');

      final messageFinder = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(HomeTvseriesPage()));
      
      expect(messageFinder, findsNWidgets(3));
    }));
  });
}
