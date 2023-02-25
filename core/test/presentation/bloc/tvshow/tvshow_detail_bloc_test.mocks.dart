// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/presentation/bloc/tvshow/tvshow_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/domain/entities/tvshow/tvshow.dart' as _i9;
import 'package:core/domain/entities/tvshow/tvshow_detail.dart' as _i7;
import 'package:core/domain/repositories/tvshow_repository.dart' as _i2;
import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart' as _i4;
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart'
    as _i8;
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshow.dart'
    as _i10;
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart'
    as _i12;
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart' as _i11;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeTvShowRepository_0 extends _i1.SmartFake
    implements _i2.TvShowRepository {
  _FakeTvShowRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTvShowDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowDetail extends _i1.Mock implements _i4.GetTvShowDetail {
  MockGetTvShowDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>.value(
                _FakeEither_1<_i6.Failure, _i7.TvShowDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>);
}

/// A class which mocks [GetTvShowRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowRecommendations extends _i1.Mock
    implements _i8.GetTvShowRecommendations {
  MockGetTvShowRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.TvShow>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetWatchListStatusTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTvShow extends _i1.Mock
    implements _i10.GetWatchListStatusTvShow {
  MockGetWatchListStatusTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTvShow extends _i1.Mock
    implements _i11.SaveWatchlistTvShow {
  MockSaveWatchlistTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvshow) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvshow],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvshow],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTvShow extends _i1.Mock
    implements _i12.RemoveWatchlistTvShow {
  MockRemoveWatchlistTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvshow) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvshow],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvshow],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
