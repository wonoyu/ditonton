import 'dart:io';

import 'package:core/core.dart';
import 'package:core/presentation/bloc/change_list_to_show_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/tv_series.dart';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<IOClient> get sslPinnedClient async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ioClient = await sslPinnedClient;
  di.init(ioClient);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<ChangeListToShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SaveWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SaveWatchlistSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchSeriesBloc>(),
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
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case OnTheAirSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirSeriesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => SeriesDetailPage(id: id));
            case SeasonDetailPage.ROUTE_NAME:
              final season = settings.arguments as Season;
              return MaterialPageRoute(
                  builder: (_) => SeasonDetailPage(season: season));
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSeriesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
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
