import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/cubit/top_rated_movie/top_rated_movie_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieCubit topRatedMovieCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieCubit =  TopRatedMovieCubit(mockGetTopRatedMovies);
  });

  group('TopRated movie cubit', () {
    test('initial state empty', () {
      expect(topRatedMovieCubit.state, TopRatedEmpty());
    });
    blocTest<TopRatedMovieCubit, TopRatedMovieState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((realInvocation) async => Right(testMovieList));
        return topRatedMovieCubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedLoading(),
        TopRatedHasData(testMovieList),
      ],
    );
    blocTest<TopRatedMovieCubit, TopRatedMovieState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedMovieCubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedLoading(),
        TopRatedError('Server Failure'),
      ],
    );
  });
}