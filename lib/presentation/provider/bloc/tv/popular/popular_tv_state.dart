part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();
  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {

}

class PopularTvLoading extends PopularTvState {}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class PopularTvHasData extends PopularTvState {
  final List<Tv> list;

  PopularTvHasData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}
