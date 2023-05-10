import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/tv/tv.dart';
import '../../domain/entities/tv/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../datasources/local/tv/tv_local_data_source.dart';
import '../datasources/remote/tv/tv_remote_data_source.dart';
import '../models/tv/tv_table.dart';


class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource tvLocalDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.tvLocalDataSource,
  });

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    try {
      final result = await remoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvAiringToday() async {
    try {
      final result = await remoteDataSource.getTvAiringToday();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvOnTheAir() async {
    try {
      final result = await remoteDataSource.getTvOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvPopular() async {
    try {
      final result = await remoteDataSource.getTvPopular();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvTopRated() async {
    try {
      final result = await remoteDataSource.getTvTopRated();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await tvLocalDataSource.getWatchlistTv();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTv(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .removeWatchlistTv(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvDetail) async {
    try {
      final result = await tvLocalDataSource
          .insertWatchlistTv(TvTable.fromEntity(tvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getRecommendationsTv(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CertificateFailure('Certificated not valid\n${e.message}'));
    }
  }
}
