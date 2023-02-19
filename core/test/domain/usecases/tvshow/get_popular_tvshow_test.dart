import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshow.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShow usecase;
  late MockTvShowRepository mockTvShowRpository;

  setUp(() {
    mockTvShowRpository = MockTvShowRepository();
    usecase = GetPopularTvShow(mockTvShowRpository);
  });

  final tTvShow = <TvShow>[];

  group('GetPopularTvShow Tests', () {
    group('execute', () {
      test(
          'should get list of tvshow from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvShowRpository.getPopularTvShow())
            .thenAnswer((_) async => Right(tTvShow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
