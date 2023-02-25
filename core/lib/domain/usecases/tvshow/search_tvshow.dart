// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class SearchTvShow {
  final TvShowRepository repository;

  SearchTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShow(query);
  }
}
