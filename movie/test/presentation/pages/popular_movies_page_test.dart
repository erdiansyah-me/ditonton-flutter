import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class FakePopularMovieState extends Fake implements PopularMovieState {}
class MockPopularMovieCubit extends MockCubit<PopularMovieState> implements PopularMovieCubit {}
void main() {
  late MockPopularMovieCubit mockCubit;
  setUpAll((){
    registerFallbackValue(FakePopularMovieState());
  });
  setUp(() {
    mockCubit = MockPopularMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(PopularLoading());
    when(() => mockCubit.fetchPopularMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([PopularLoading()]));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenAnswer((realInvocation) => PopularHasData(testMovieList));
    when(() => mockCubit.fetchPopularMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([PopularHasData(testMovieList)]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(PopularError('message'));
    when(() => mockCubit.fetchPopularMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([PopularError('message')]));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
