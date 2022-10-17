import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/popular_tvseries/popular_tvseries_cubit.dart';
import 'package:tvseries/presentation/page/popular_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakePopularTvseriesState extends Fake implements PopularTvseriesState {}
class MockPopularTvseriesCubit extends MockCubit<PopularTvseriesState> implements PopularTvseriesCubit {}
void main() {
  late MockPopularTvseriesCubit mockCubit;
  setUpAll(() {
    registerFallbackValue(FakePopularTvseriesState());
  });
  setUp((){
    mockCubit = MockPopularTvseriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvseriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('popular tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(PopularLoading());
      when(() => mockCubit.fetchPopularSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([PopularLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() =>mockCubit.state).thenReturn(PopularHasData(testTvseriesList));
      when(() => mockCubit.fetchPopularSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([PopularHasData(testTvseriesList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(PopularError('message'));
      when(() => mockCubit.fetchPopularSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([PopularLoading()]));

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}