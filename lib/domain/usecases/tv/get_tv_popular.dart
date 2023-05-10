import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';


class GetTvPopular {
  final TvRepository repository;

  GetTvPopular(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvPopular();
  }
}