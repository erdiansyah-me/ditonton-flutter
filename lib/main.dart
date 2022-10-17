
import 'dart:async';

import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final crashlytics = FirebaseCrashlytics.instance;
    FlutterError.onError = crashlytics.recordFlutterFatalError;
    di.init();
    await di.locator.allReady();
    runApp(MyApp());
  }, (error, stack) => 
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieCubit>(),
        ),

        BlocProvider(
          create:  (_) => di.locator<TvseriesSearchBloc>(),
        ),
        BlocProvider(
          create:  (_) => di.locator<PopularTvseriesCubit>(),
        ),
        BlocProvider(
          create:  (_) => di.locator<TopRatedTvseriesCubit>(),
        ),
        BlocProvider(
          create:  (_) => di.locator<WatchlistTvseriesCubit>(),
        ),
        BlocProvider(
          create:  (_) => di.locator<TvseriesListCubit>(),
        ),
        BlocProvider(
          create:  (_) => di.locator<TvseriesDetailCubit>(),
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
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvseriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvseriesPage());
            case TvseriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvseriesDetailPage(id: id),
                settings: settings,
              );
            case PopularTvseriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvseriesPage());
            case TopRatedTvseriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvseriesPage());
            case WatchlistTvseriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvseriesPage());
            case TvseriesSearchPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvseriesSearchPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
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
