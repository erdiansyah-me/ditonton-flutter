import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockProvider;

  setUp((){
    mockProvider = MockMovieSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('search tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Loaded);
      when(mockProvider.searchResult).thenReturn(<Movie>[]);

      final listviewFinder = find.byType(ListView);
      final textFieldFinder = find.byType(TextField);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));
      await tester.enterText(textFieldFinder, 'attack on titan');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(mockProvider.state).thenReturn(RequestState.Error);
      when(mockProvider.message).thenReturn('Error message');

      final containerFinder = find.byType(Container);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(containerFinder, findsOneWidget);
    });
  });
}