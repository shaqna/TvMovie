import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/movie/movie.dart';
import '../../../../../domain/usecases/movie/get_popular_movies.dart';

part 'popular_movie_event.dart';

part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnFetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());

      final results = await _getPopularMovies.execute();

      results.fold((failure) {
        emit(PopularMovieError(failure.message));
      }, (movies) {
        emit(PopularMovieHasData(movies));
      });
    });
  }
}
