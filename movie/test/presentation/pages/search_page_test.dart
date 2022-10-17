import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeMovieSearchEvent extends Fake implements MovieSearchEvent {}
class FakeMovieSearchState extends Fake implements MovieSearchState {}
class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState> implements MovieSearchBloc {}
void main() {
  late MockMovieSearchBloc mockBloc;
  String tQuery = 'attach on titan';
  setUpAll(() {
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
  });
  setUp((){
    mockBloc = MockMovieSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>.value(
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

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SearchHasData(testMovieList));
      when(() => mockBloc.add(OnQueryChanged(tQuery))).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockBloc, Stream.fromIterable([SearchHasData(testMovieList)]));

      final listviewFinder = find.byType(ListView);
      final textFieldFinder = find.byType(TextField);

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      await tester.enterText(textFieldFinder, 'attack on titan');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(const SearchError('message'));
      when(() => mockBloc.add(OnQueryChanged(tQuery))).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockBloc, Stream.fromIterable([const SearchError('message')]));

      final textFinder = find.text('message');

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}