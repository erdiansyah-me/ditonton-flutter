import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/domain/entities/Tvseries.dart';
import 'package:tvseries/presentation/bloc/cubit/tvseries_list/tvseries_list_cubit.dart';
import 'package:tvseries/presentation/page/home_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tvseries_dummy_objects.dart';

class FakeTvseriesListState extends Fake implements TvseriesListState {}
class MockTvseriesListCubit extends MockCubit<TvseriesListState> implements TvseriesListCubit {}
void main() {
  late MockTvseriesListCubit mockCubit;

  setUp(() {
    mockCubit = MockTvseriesListCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvseriesListCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('tvseries list page', () {
    testWidgets('should display loading progress when data loading',
        ((WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(ListLoading());
      when(() => mockCubit.fetchListSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([ListLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const HomeTvseriesPage()));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    }));

    testWidgets('should display listview when data loaded',
        ((WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(ListHasData(onTheAirSeriesResult: testTvseriesList, popularSeriesResult: testTvseriesList, topRatedSeriesResult: testTvseriesList));
      when(() => mockCubit.fetchListSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([ListHasData(onTheAirSeriesResult: testTvseriesList, popularSeriesResult: testTvseriesList, topRatedSeriesResult: testTvseriesList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const HomeTvseriesPage()));
      
      expect(listviewFinder, findsNWidgets(3));
    }));

    testWidgets('should display error message when data Error',
        ((WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(const ListError('message'));
      when(() => mockCubit.fetchListSeries()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([const ListError('message')]));

      final messageFinder = find.text('message');

      await tester.pumpWidget(_makeTestableWidget(const HomeTvseriesPage()));
      
      expect(messageFinder, findsNWidgets(3));
    }));
  });
}
