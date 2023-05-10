
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/movie/movie.dart';
import '../../../../../domain/usecases/movie/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  
  WatchlistMovieBloc(this._getWatchlistMovies) : super(WatchlistMovieEmpty()) {
    on<OnFetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      var result = await _getWatchlistMovies.execute();
      result.fold((failure){
        emit(WatchlistMovieError(failure.message));
      }, (moviesData){
        emit(WatchlistMovieHasData(moviesData));
      });
    });
  }
}
