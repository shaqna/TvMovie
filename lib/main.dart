import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_movie_app/common/constants.dart';
import 'package:tv_movie_app/common/utils.dart';
import 'package:tv_movie_app/injection.dart' as di;
import 'package:tv_movie_app/presentation/pages/about/about_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/home_movie_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/movie_detail_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/popular_movies_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/search_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:tv_movie_app/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/home_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/on_the_air_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv_movie_app/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/popular/popular_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/recommendations/recommendation_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/search/search_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/movie/watchlist_status/watchlist_movie_status_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/%20now_playing/now_playing_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/detail/detail_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/recommendation/tv_recommendation_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/search/search_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:tv_movie_app/presentation/provider/bloc/tv/watchlist_status/watchlist_tv_status_bloc.dart';

import 'presentation/pages/tv/search_tv_page.dart';
import 'presentation/pages/tv/tv_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistTvPage());
            case OnTheAirTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const OnTheAirTvPage());
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TopRatedTvPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchTvPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
