import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tvshow/tvshow_detail.dart';
import '../../repositories/tvshow_repository.dart';

class GetTvShowDetail {
  final TvShowRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) => repository.getTvShowDetail(id);
}