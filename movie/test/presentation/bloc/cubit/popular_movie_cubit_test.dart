import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/cubit/popular_movie/popular_movie_cubit.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieCubit popularMovieCubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieCubit =  PopularMovieCubit(mockGetPopularMovies);
  });

  group('popular movie cubit', () {
    test('initial state empty', () {
      expect(popularMovieCubit.state, PopularEmpty());
    });
    blocTest<PopularMovieCubit, PopularMovieState>(
      'emits [Loading, hasdata] when get data succeed.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((realInvocation) async => Right(testMovieList));
        return popularMovieCubit;
      },
      act: (cubit) => cubit.fetchPopularMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularLoading(),
        PopularHasData(testMovieList),
      ],
    );
    blocTest<PopularMovieCubit, PopularMovieState>(
      'emits [Loading, Error] when get data failed.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularMovieCubit;
      },
      act: (cubit) => cubit.fetchPopularMovie(),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularLoading(),
        PopularError('Server Failure'),
      ],
    );
  });
}