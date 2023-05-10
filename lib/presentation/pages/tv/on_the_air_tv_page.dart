import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../provider/bloc/tv/ now_playing/now_playing_tv_bloc.dart';
import '../../widgets/tv_card_list.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  const OnTheAirTvPage({super.key});

  @override
  _OnTheAirTvPageState createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<NowPlayingTvBloc>(context).add(OnFetchOnTheAirTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
          builder: (context, state) {
            if (state is NowPlayingTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.list[index];
                  return TvCard(tv);
                },
                itemCount: state.list.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
