import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/tvseries.dart';
import 'package:tvseries/presentation/page/tvseries_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakeTvseriesDetailState extends Fake implements TvseriesDetailState {}
class MockTvseriesDetailCubit extends MockCubit<TvseriesDetailState> implements TvseriesDetailCubit {}
void main() {
  late MockTvseriesDetailCubit mockCubit;
  const tId = 1;
  setUpAll((){
    registerFallbackValue(FakeTvseriesDetailState());
  });

  setUp(() {
    mockCubit = MockTvseriesDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvseriesDetailCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when Tvseries not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testTvseriesDetail, testTvseriesList, false));
    when(() => mockCubit.fetchTvseriesDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testTvseriesDetail, testTvseriesList, false)]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tvseries is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testTvseriesDetail, testTvseriesList, true));
    when(() => mockCubit.fetchTvseriesDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testTvseriesDetail, testTvseriesList, true)]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(DetailHasData(testTvseriesDetail, testTvseriesList, false));
    when(() => mockCubit.message).thenReturn('Added to Watchlist');
    when(() => mockCubit.fetchTvseriesDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    when(() => mockCubit.addSeriesWatchlist(testTvseriesDetail)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testTvseriesDetail, testTvseriesList, false)]));
    

    

    await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));
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
    when(() => mockCubit.state).thenReturn(DetailHasData(testTvseriesDetail, testTvseriesList, false));
    when(() => mockCubit.message).thenReturn('Failed');
    when(() => mockCubit.fetchTvseriesDetail(tId)).thenAnswer((realInvocation) async => realInvocation);
    when(() => mockCubit.addSeriesWatchlist(testTvseriesDetail)).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([DetailHasData(testTvseriesDetail, testTvseriesList, false)]));
    

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvseriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
