import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/tv/tv.dart';
import '../../../../../domain/usecases/tv/get_tv_popular.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetTvPopular _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(PopularTvEmpty()) {
    on<OnFetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final results = await _getPopularTv.execute();

      results.fold(
          (failure){
            emit(PopularTvError(failure.message));
          },
          (list){
            emit(PopularTvHasData(list));
          }
      );
    });
  }
}
