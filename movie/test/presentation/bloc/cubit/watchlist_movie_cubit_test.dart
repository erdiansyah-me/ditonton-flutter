import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/cubit/watchlist_movie/watchlist_movie_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieCubit =  WatchlistMovieCubit(mockGetWatchlistMovies);
  });

  group('Watchlist movie cubit', () {
    test('initial state empty', () {
      expect(watchlistMovieCubit.state, WatchlistEmpty());
    });
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer((realInvocation) async => Right(testMovieList));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.fetchWatchlistMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(testMovieList),
      ],
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.fetchWatchlistMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistLoading(),
        WatchlistError('Server Failure'),
      ],
    );
  });
}