import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/top_rated_tvseries/top_rated_tvseries_cubit.dart';
import 'package:tvseries/presentation/page/top_rated_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakeTopRatedTvseriesState extends Fake implements TopRatedTvseriesState {}
class MockTopRatedTvseriesCubit extends MockCubit<TopRatedTvseriesState> implements TopRatedTvseriesCubit {}
void main() {
  late MockTopRatedTvseriesCubit mockCubit;
  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvseriesState());
  });
  setUp((){
    mockCubit = MockTopRatedTvseriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvseriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  group('TopRated tv series page', () {
    testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(TopRatedLoading());
      when(() => mockCubit.fetchTopRatedSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([TopRatedLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() =>mockCubit.state).thenReturn(TopRatedHasData(testTvseriesList));
      when(() => mockCubit.fetchTopRatedSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([TopRatedHasData(testTvseriesList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(TopRatedError('message'));
      when(() => mockCubit.fetchTopRatedSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([TopRatedLoading()]));

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}