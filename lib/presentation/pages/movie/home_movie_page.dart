import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_movie_app/presentation/pages/movie/popular_movies_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/search_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/watchlist_movies_page.dart';

import '../../../common/constants.dart';
import '../../components/movie_list.dart';
import '../../provider/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import '../../provider/bloc/movie/popular/popular_movie_bloc.dart';
import '../../provider/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import '../about/about_page.dart';
import '../tv/home_tv_page.dart';
import '../tv/watchlist_tv_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(OnFetchNowPlayingMovie());
      context.read<PopularMovieBloc>().add(OnFetchPopularMovie());
      context.read<TopRatedMovieBloc>().add(OnFetchTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-quwel.jpg'),
              ),
              accountName: Text('Shaquille Rizki Ramadhan Na'),
              accountEmail: Text('shaquillerizkirn@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: const Icon(Icons.tv),
                title: const Text('TV'),
                onTap: () {
                  Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
                }),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist (Movie)'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist (TV)'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TvMovie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                  builder: (context, state) {
                if (state is NowPlayingMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMovieHasData) {
                  return MovieList(state.movies);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, state) {
                if (state is PopularMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieHasData) {
                  return MovieList(state.movies);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                  builder: (context, state) {
                if (state is TopRatedMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieHasData) {
                  return MovieList(state.movies);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
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
}
