part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();
  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {

}

class WatchlistTvLoading extends WatchlistTvState{}

class WatchlistTvError extends WatchlistTvState {
  final String message;
  WatchlistTvError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];

}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> list;

  WatchlistTvHasData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}
