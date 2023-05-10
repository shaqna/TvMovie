import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';


class GetTvOnTheAir {
  final TvRepository repository;

  GetTvOnTheAir(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvOnTheAir();
  }
}