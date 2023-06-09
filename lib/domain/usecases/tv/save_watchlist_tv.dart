import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv_repository.dart';


class SaveWatchlistTv{
  final TvRepository repository;
  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail){
    return repository.saveWatchlistTv(tvDetail);
  }
}