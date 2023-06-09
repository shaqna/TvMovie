part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object?> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail detailMovie;

  const DetailMovieHasData(this.detailMovie);

  @override
  List<Object?> get props => [detailMovie];
}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError(this.message);

  @override
  List<Object?> get props => [message];
}
