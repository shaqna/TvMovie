import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/tv/tv.dart';
import '../../../../../domain/usecases/tv/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTvs;
  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistTvEmpty()) {
    on<OnFetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());

      final results = await _getWatchlistTvs.execute();

      results.fold(
          (failure) {
            emit(WatchlistTvError(failure.message));
          },
          (list) {
            emit(WatchlistTvHasData(list));
          }
      );
    });
  }
}
