import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakeTvseriesSearchEvent extends Fake implements TvseriesSearchEvent {}
class FakeTvseriesSearchState extends Fake implements TvseriesSearchState {}
class MockTvseriesSearchBloc extends MockBloc<TvseriesSearchEvent, TvseriesSearchState> implements TvseriesSearchBloc {}
void main() {
  late MockTvseriesSearchBloc mockBloc;
  String tQuery = 'attach on titan';
  setUpAll(() {
    registerFallbackValue(FakeTvseriesSearchEvent());
    registerFallbackValue(FakeTvseriesSearchState());
  });
  setUp((){
    mockBloc = MockTvseriesSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvseriesSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('search tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SearchHasData(testTvseriesList));
      when(() => mockBloc.add(OnQueryChanged(tQuery))).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockBloc, Stream.fromIterable([SearchHasData(testTvseriesList)]));

      final listviewFinder = find.byType(ListView);
      final textFieldFinder = find.byType(TextField);

      await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));
      await tester.enterText(textFieldFinder, 'attack on titan');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SearchError('message'));
      when(() => mockBloc.add(OnQueryChanged(tQuery))).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockBloc, Stream.fromIterable([SearchError('message')]));

      final textFinder = find.text('message');

      await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}