import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/cubit/home_movie/home_movie_cubit.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeHomeMovieState extends Fake implements HomeMovieState {}
class MockHomeMovieCubit extends MockCubit<HomeMovieState> implements HomeMovieCubit {}
void main() {
  late MockHomeMovieCubit mockCubit;

  setUp(() {
    mockCubit = MockHomeMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<HomeMovieCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('HomeMovie page', () {
    testWidgets('should display loading progress when data loading',
        (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(HomeLoading());
      when(() => mockCubit.fetchHomeMovieList()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([HomeLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    });

    testWidgets('should display listview when data loaded',
        ((WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(HomeHasData(nowPlayingMovieResult: testMovieList, popularMovieResult: testMovieList, topRatedMovieResult: testMovieList));
      when(() => mockCubit.fetchHomeMovieList()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([HomeHasData(nowPlayingMovieResult: testMovieList, popularMovieResult: testMovieList, topRatedMovieResult: testMovieList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));
      
      expect(listviewFinder, findsNWidgets(3));
    }));

    testWidgets('should display error message when data Error',
        (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(HomeError('message'));
      when(() => mockCubit.fetchHomeMovieList()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([HomeError('message')]));

      final messageFinder = find.text('message');

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));
      
      expect(messageFinder, findsNWidgets(3));
    });
  });
}
