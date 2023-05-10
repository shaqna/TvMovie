import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetRecommendationsTv {
  final TvRepository repository;

  GetRecommendationsTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getRecommendationsTv(id);
  }
}