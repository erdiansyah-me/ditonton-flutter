import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/watchlist_tvseries/watchlist_tvseries_cubit.dart';
import 'package:tvseries/presentation/page/watchlist_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakeWatchlistTvseriesState extends Fake implements WatchlistTvseriesState {}
class MockWatchlistTvseriesCubit extends MockCubit<WatchlistTvseriesState> implements WatchlistTvseriesCubit {}
void main() {
  late MockWatchlistTvseriesCubit mockCubit;
  setUpAll(() {
    registerFallbackValue(FakeWatchlistTvseriesState());
  });
  setUp((){
    mockCubit = MockWatchlistTvseriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvseriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('Watchlist tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(WatchlistLoading());
      when(() => mockCubit.fetchWatchlistSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() =>mockCubit.state).thenReturn(WatchlistHasData(testTvseriesList));
      when(() => mockCubit.fetchWatchlistSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistHasData(testTvseriesList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(WatchlistError('message'));
      when(() => mockCubit.fetchWatchlistSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistLoading()]));

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}