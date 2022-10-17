import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeMovieDetailState extends Fake implements MovieDetailState {}
class MockMovieDetailCubit extends MockCubit<MovieDetailState> implements MovieDetailCubit {}
void main() {
  late MockMovieDetailCubit mockCubit;
  const tId = 1;
  setUpAll((){
    registerFallbackValue(FakeMovieDetailState());
  });

  setUp(() {
    mockCubit = MockMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testMovieDetail, testMovieList, false));
    when(() => mockCubit.fetchMovieDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testMovieDetail, testMovieList, false)]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testMovieDetail, testMovieList, true));
    when(() => mockCubit.fetchMovieDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testMovieDetail, testMovieList, true)]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testMovieDetail, testMovieList, false));
    when(() => mockCubit.message).thenReturn('Added to Watchlist');
    when(() => mockCubit.fetchMovieDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    when(() => mockCubit.addMovieWatchlist(testMovieDetail)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testMovieDetail, testMovieList, false)]));
    

    

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    final watchlistButton = find.byType(ElevatedButton);
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    // expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testMovieDetail, testMovieList, false));
    when(() => mockCubit.message).thenReturn('Failed');
    when(() => mockCubit.fetchMovieDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    when(() => mockCubit.addMovieWatchlist(testMovieDetail)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testMovieDetail, testMovieList, false)]));
    

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
