// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/presentation/provider/tvshow/tvshow_list_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/domain/entities/tvshow/tvshow.dart' as _i7;
import 'package:core/domain/repositories/tvshow_repository.dart' as _i2;
import 'package:core/domain/usecases/tvshow/get_airing_today_tvshow.dart'
    as _i4;
import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart' as _i8;
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshow.dart' as _i9;
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

/// A class which mocks [GetAiringTodayTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAiringTodayTvShow extends _i1.Mock
    implements _i4.GetAiringTodayTvShow {
  MockGetAiringTodayTvShow() {
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
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.TvShow>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetPopularTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvShow extends _i1.Mock implements _i8.GetPopularTvShow {
  MockGetPopularTvShow() {
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
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.TvShow>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetTopRatedTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvShow extends _i1.Mock implements _i9.GetTopRatedTvShow {
  MockGetTopRatedTvShow() {
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
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.TvShow>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}
