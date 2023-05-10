import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/tv/tv_detail.dart';
import '../../../../../domain/usecases/tv/get_watch_list_tv_status.dart';
import '../../../../../domain/usecases/tv/remove_watchlist_tv.dart';
import '../../../../../domain/usecases/tv/save_watchlist_tv.dart';

part 'watchlist_tv_status_event.dart';

part 'watchlist_tv_status_state.dart';

class WatchlistTvStatusBloc
    extends Bloc<WatchlistTvStatusEvent, WatchlistTvStatusState> {
  final GetWatchListStatusTv _getWatchListStatusTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final SaveWatchlistTv _saveWatchlistTv;

  WatchlistTvStatusBloc(this._getWatchListStatusTv, this._removeWatchlistTv,
      this._saveWatchlistTv)
      : super(WatchlistTvStatusEmpty()) {
    on<OnFetchWatchlistStatus>((event, emit) async {
      emit(WatchlistTvStatusLoading());
      final isAddedToWatchlist = await _getWatchListStatusTv.execute(event.id);

      emit(WatchlistTvStatusHasData(isAddedToWatchlist, 'message'));
    });

    on<OnAddedToWatchlist>((event, emit) async {
      emit(WatchlistTvStatusLoading());

      final result = await _saveWatchlistTv.execute(event.tv);

      await result.fold((failure) async {
        emit(WatchlistTvStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist =
        await _getWatchListStatusTv.execute(event.tv.id);

        emit(WatchlistTvStatusHasData(
            isAddedToWatchlist, 'message'));
      });
    });

    on<OnRemoveFromWatchList>((event, emit) async {
      emit(WatchlistTvStatusLoading());

      final result = await _removeWatchlistTv.execute(event.tv);

      await result.fold((failure) async {
        emit(WatchlistTvStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist =
        await _getWatchListStatusTv.execute(event.tv.id);
        emit(WatchlistTvStatusHasData(
            isAddedToWatchlist, 'message'));
      });
    });
  }
}
