import 'package:core/common/state_enum.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:tvseries/presentation/page/tvseries_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';



@GenerateMocks([TvseriesSearchBloc])
void main() {
  // late MockTvseriesSearchNotifier mockProvider;

  // setUp((){
  //   mockProvider = MockTvseriesSearchNotifier();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TvseriesSearchNotifier>.value(
  //     value: mockProvider,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  // group('search tv series page', () {
  //   testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //     when(mockProvider.state).thenReturn(RequestState.Loading);

  //     final progressBarFinder = find.byType(CircularProgressIndicator);

  //     await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));

  //     expect(progressBarFinder, findsOneWidget);
  //   });

  //   testWidgets('Page should display listview when data loaded',
  //     (WidgetTester tester) async {
  //     when(mockProvider.state).thenReturn(RequestState.Loaded);
  //     when(mockProvider.searchSeriesResult).thenReturn(<Tvseries>[]);

  //     final listviewFinder = find.byType(ListView);
  //     final textFiledFinder = find.byType(TextField);

  //     await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));
  //     await tester.enterText(textFiledFinder, 'attack on titan');
  //     await tester.testTextInput.receiveAction(TextInputAction.search);
  //     await tester.pump();

  //     expect(listviewFinder, findsOneWidget);
  //   });

  //   testWidgets('Page should display error text when error',
  //     (WidgetTester tester) async {
  //     when(mockProvider.state).thenReturn(RequestState.Error);
  //     when(mockProvider.message).thenReturn('Error message');

  //     final containerFinder = find.byType(Container);

  //     await tester.pumpWidget(_makeTestableWidget(TvseriesSearchPage()));

  //     expect(containerFinder, findsOneWidget);
  //   });
  // });
}