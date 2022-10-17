import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeTopRatedMovieState extends Fake implements TopRatedMovieState {}
class MockTopRatedMovieCubit extends MockCubit<TopRatedMovieState> implements TopRatedMovieCubit {}
void main() {
  late MockTopRatedMovieCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedMovieState());
  });
  setUp(() {
    mockCubit = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(TopRatedLoading());
    when(() => mockCubit.fetchTopRatedMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([TopRatedLoading()]));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenAnswer((realInvocation) => TopRatedHasData(testMovieList));
    when(() => mockCubit.fetchTopRatedMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([TopRatedHasData(testMovieList)]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenAnswer((realInvocation) => TopRatedError('message'));
    when(() => mockCubit.fetchTopRatedMovie()).thenAnswer((realInvocation) async => realInvocation);
    whenListen(mockCubit, Stream.fromIterable([TopRatedError('message')]));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
