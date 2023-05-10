part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();
  @override
  List<Object> get props => [];
}

class NowPlayingTvEmpty extends NowPlayingTvState {

}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  NowPlayingTvError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NowPlayingTvHasData extends NowPlayingTvState {
  final List<Tv> list;

  NowPlayingTvHasData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}