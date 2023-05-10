import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_movie_app/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/search_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/top_rated_tv_page.dart';

import '../../../common/constants.dart';
import '../../../common/utils.dart';
import '../../components/tv_list.dart';
import '../../provider/bloc/tv/ now_playing/now_playing_tv_bloc.dart';
import '../../provider/bloc/tv/popular/popular_tv_bloc.dart';
import '../../provider/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'on_the_air_tv_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-page';

  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(OnFetchOnTheAirTv());
      context.read<PopularTvBloc>().add(OnFetchPopularTv());
      context.read<TopRatedTvBloc>().add(OnFetchTopRatedTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<NowPlayingTvBloc>().add(OnFetchOnTheAirTv());
    context.read<PopularTvBloc>().add(OnFetchPopularTv());
    context.read<TopRatedTvBloc>().add(OnFetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                    title: 'TV Now Playing',
                    onTap: () {
                      Navigator.pushNamed(context, OnTheAirTvPage.ROUTE_NAME);
                    }),
                BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                    builder: (context, state) {
                  if (state is NowPlayingTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvHasData) {
                    return TvList(state.list);
                  } else {
                    return const Text('Failed');
                  }
                }),
                _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () {
                      Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME);
                    }),
                BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                    builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvHasData) {
                    return TvList(state.list);
                  } else {
                    return const Text('Failed');
                  }
                }),
                _buildSubHeading(
                    title: 'Popular',
                    onTap: () {
                      Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME);
                    }),
                BlocBuilder<PopularTvBloc, PopularTvState>(
                    builder: (context, state) {
                  if (state is PopularTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvHasData) {
                    return TvList(state.list);
                  } else {
                    return const Text('Failed');
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
