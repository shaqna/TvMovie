import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/tv/tv_detail.dart';
import '../../../../../domain/usecases/tv/get_tv_detail.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getTvDetail;

  DetailTvBloc(this._getTvDetail) : super(DetailTvEmpty()) {
    on<OnFetchDetailTv>((event, emit) async {
      emit(DetailTvLoading());

      final result = await _getTvDetail.execute(event.id);

      result.fold(
          (failure) {
            emit(DetailTvError(failure.message));
          },
          (tv) {
            emit(DetailTvHasData(tv));
          }
      );
    });
  }
}
