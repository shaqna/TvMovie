import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/movie/movie.dart';
import '../../../../../domain/usecases/movie/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations) : super(RecommendationMovieEmpty()) {
    on<OnFetchRecommendationMovie>((event, emit) async {
      emit(RecommendationMovieLoading());
      final results = await _getMovieRecommendations.execute(event.id);

      results.fold(
          (failure) {
            emit(RecommendationMovieError(failure.message));
          },
          (movies) {
            emit(RecommendationMovieHasData(movies));
          }
      );
    });
  }
}
