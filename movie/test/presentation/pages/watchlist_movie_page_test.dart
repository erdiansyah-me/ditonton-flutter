import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}
class MockWatchlistMovieCubit extends MockCubit<WatchlistMovieState> implements WatchlistMovieCubit {}
void main() {
  late MockWatchlistMovieCubit mockCubit;
  setUpAll(() {
    registerFallbackValue(FakeWatchlistMovieState());
  });
  setUp((){
    mockCubit = MockWatchlistMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieCubit>.value(
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
      when(() => mockCubit.fetchWatchlistMovie()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistLoading()]));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display listview when data loaded',
      (WidgetTester tester) async {
      when(() =>mockCubit.state).thenReturn(WatchlistHasData(testMovieList));
      when(() => mockCubit.fetchWatchlistMovie()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistHasData(testMovieList)]));

      final listviewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('Page should display error text when error',
      (WidgetTester tester) async {
      when(() => mockCubit.state).thenReturn(WatchlistError('message'));
      when(() => mockCubit.fetchWatchlistMovie()).thenAnswer((realInvocation) async => realInvocation);
      whenListen(mockCubit, Stream.fromIterable([WatchlistLoading()]));

      final textErrorFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(textErrorFinder, findsOneWidget);
    });
  });
}