import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';


class GetTvTopRated {
  final TvRepository repository;

  GetTvTopRated(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvTopRated();
  }
}
