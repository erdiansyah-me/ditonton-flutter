import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/cubit/home_movie/home_movie_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'home_movie_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late HomeMovieCubit homeMovieCubit;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    homeMovieCubit = HomeMovieCubit(
      mockGetNowPlayingMovies,
      mockGetPopularMovies,
      mockGetTopRatedMovies,
    );
  });

  group('home movie cubit', () {
    test('initial state empty', () {
      expect(homeMovieCubit.state, HomeEmpty());
    });

    blocTest<HomeMovieCubit, HomeMovieState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((realInvocation) async => Right(testMovieList));
        when(mockGetPopularMovies.execute())
            .thenAnswer((realInvocation) async => Right(testMovieList));
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((realInvocation) async => Right(testMovieList));
        return homeMovieCubit;
      },
      act: (cubit) => cubit.fetchHomeMovieList(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeLoading(),
        HomeHasData(
          nowPlayingMovieResult: testMovieList,
          popularMovieResult: testMovieList,
          topRatedMovieResult: testMovieList,
        ),
      ],
    );
    blocTest<HomeMovieCubit, HomeMovieState>(
      'emits [Loading, error] when one of get data failed.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        when(mockGetPopularMovies.execute())
            .thenAnswer((realInvocation) async => Right(testMovieList));
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((realInvocation) async => Right(testMovieList));
        return homeMovieCubit;
      },
      act: (cubit) => cubit.fetchHomeMovieList(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeLoading(),
        HomeHasData(nowPlayingMovieResult: const [], popularMovieResult: testMovieList, topRatedMovieResult: testMovieList),
      ],
    );
    blocTest<HomeMovieCubit, HomeMovieState>(
      'emits [Loading, error] when all get data failed.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed to Load Data')));
        when(mockGetPopularMovies.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed to Load Data')));
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((realInvocation) async => Left(ServerFailure('Failed to Load Data')));
        return homeMovieCubit;
      },
      act: (cubit) => cubit.fetchHomeMovieList(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        HomeLoading(),
        HomeError('Failed to Load Data'),
      ],
    );
  });
}
