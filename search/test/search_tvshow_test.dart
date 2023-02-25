import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/tvshow/search_tvshow.dart';

import '../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShow(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];
  const tQuery = 'Julekalender';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShow));
  });
}
