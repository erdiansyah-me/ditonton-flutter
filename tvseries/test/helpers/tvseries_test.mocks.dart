// Mocks generated by Mockito 5.3.2 from annotations
// in tvseries/test/helpers/tvseries_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:core/common/failure.dart' as _i7;
import 'package:core/data/database/database_helper.dart' as _i14;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/models/movie_table.dart' as _i16;
import 'package:sqflite/sqflite.dart' as _i15;
import 'package:tvseries/data/datasource/tvseries_local_data_source.dart'
    as _i12;
import 'package:tvseries/data/datasource/tvseries_remote_data_source.dart'
    as _i10;
import 'package:tvseries/data/model/tvseries_detail_model.dart' as _i3;
import 'package:tvseries/data/model/tvseries_model.dart' as _i11;
import 'package:tvseries/data/model/tvseries_table.dart' as _i13;
import 'package:tvseries/domain/entities/Tvseries.dart' as _i8;
import 'package:tvseries/domain/entities/Tvseries_detail.dart' as _i9;
import 'package:tvseries/domain/repository/tvseries_repository.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvseriesDetailResponse_1 extends _i1.SmartFake
    implements _i3.TvseriesDetailResponse {
  _FakeTvseriesDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvseriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesRepository extends _i1.Mock
    implements _i5.TvseriesRepository {
  MockTvseriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>> getOnTheAirSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnTheAirSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
          this,
          Invocation.method(
            #getOnTheAirSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>> getPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
          this,
          Invocation.method(
            #getPopularSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
          this,
          Invocation.method(
            #getTopRatedSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TvseriesDetail>> getTvseriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i9.TvseriesDetail>>.value(
                _FakeEither_0<_i7.Failure, _i9.TvseriesDetail>(
          this,
          Invocation.method(
            #getTvseriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i9.TvseriesDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>
      getRecommendationSeries(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getRecommendationSeries,
              [id],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
              this,
              Invocation.method(
                #getRecommendationSeries,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>> searchSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
          this,
          Invocation.method(
            #searchSeries,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveSeriesWatchlist(
          _i9.TvseriesDetail? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSeriesWatchlist,
          [tvseries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveSeriesWatchlist,
            [tvseries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeSeriesWatchlist(
          _i9.TvseriesDetail? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSeriesWatchlist,
          [tvseries],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeSeriesWatchlist,
            [tvseries],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToSeriesWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToSeriesWatchlist,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>
      getWatchlistSeries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i8.Tvseries>>(
              this,
              Invocation.method(
                #getWatchlistSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Tvseries>>>);
}

/// A class which mocks [TvseriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesRemoteDataSource extends _i1.Mock
    implements _i10.TvseriesRemoteDataSource {
  MockTvseriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TvseriesModel>> getOnTheAirSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnTheAirSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvseriesModel>>.value(<_i11.TvseriesModel>[]),
      ) as _i6.Future<List<_i11.TvseriesModel>>);
  @override
  _i6.Future<List<_i11.TvseriesModel>> getPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvseriesModel>>.value(<_i11.TvseriesModel>[]),
      ) as _i6.Future<List<_i11.TvseriesModel>>);
  @override
  _i6.Future<List<_i11.TvseriesModel>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i11.TvseriesModel>>.value(<_i11.TvseriesModel>[]),
      ) as _i6.Future<List<_i11.TvseriesModel>>);
  @override
  _i6.Future<_i3.TvseriesDetailResponse> getTvseriesDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.TvseriesDetailResponse>.value(
            _FakeTvseriesDetailResponse_1(
          this,
          Invocation.method(
            #getTvseriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.TvseriesDetailResponse>);
  @override
  _i6.Future<List<_i11.TvseriesModel>> getRecommendationSeries(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecommendationSeries,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i11.TvseriesModel>>.value(<_i11.TvseriesModel>[]),
      ) as _i6.Future<List<_i11.TvseriesModel>>);
  @override
  _i6.Future<List<_i11.TvseriesModel>> searchSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i11.TvseriesModel>>.value(<_i11.TvseriesModel>[]),
      ) as _i6.Future<List<_i11.TvseriesModel>>);
}

/// A class which mocks [TvseriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesLocalDataSource extends _i1.Mock
    implements _i12.TvseriesLocalDataSource {
  MockTvseriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertSeriesWatchlist(_i13.TvseriesTable? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertSeriesWatchlist,
          [series],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> removeSeriesWatchlist(_i13.TvseriesTable? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSeriesWatchlist,
          [series],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i13.TvseriesTable?> getSeriesById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getSeriesById,
          [id],
        ),
        returnValue: _i6.Future<_i13.TvseriesTable?>.value(),
      ) as _i6.Future<_i13.TvseriesTable?>);
  @override
  _i6.Future<List<_i13.TvseriesTable>> getWatchlistSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i13.TvseriesTable>>.value(<_i13.TvseriesTable>[]),
      ) as _i6.Future<List<_i13.TvseriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i14.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i15.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i6.Future<_i15.Database?>.value(),
      ) as _i6.Future<_i15.Database?>);
  @override
  _i6.Future<int> insertSeriesWatchlist(_i13.TvseriesTable? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertSeriesWatchlist,
          [series],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> removeSeriesWatchlist(_i13.TvseriesTable? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSeriesWatchlist,
          [series],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeriesById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistSeries,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i18.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i18.Uint8List>.value(_i18.Uint8List(0)),
      ) as _i6.Future<_i18.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}