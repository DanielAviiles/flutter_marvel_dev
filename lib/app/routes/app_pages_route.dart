import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin AppPagesRoute {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      /* AppRoutes.home: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider<MovieNowPLayingBloc>(
                child: const HomePage(),
                create: (context) => MovieNowPLayingBloc(
                  moviesRemoteUseCase: getItApp<GetMoviesRemoteUsecase>(),
                ),
              ),
              BlocProvider<MoviePopularBloc>(
                child: const HomePage(),
                create: (context) => MoviePopularBloc(
                  moviesPopularsRemoteUsecase:
                      getItApp<GetMoviesPopularsRemoteUsecase>(),
                ),
              ),
              BlocProvider<MovieSearchedBloc>(
                child: const HomePage(),
                create: (context) => MovieSearchedBloc(
                  searchMovieRemoteUsecase:
                      getItApp<GetSearchMovieRemoteUsecase>(),
                ),
              ),
              /* BlocProvider<MovieSearchedBloc>(
                child: MovieSearchDelegate(),
                create: (context) => MovieSearchedBloc(
                  searchMovieRemoteUsecase:
                      getItApp<GetSearchMovieRemoteUsecase>(),
                ),
              ) */
            ],
            child: const HomePage(),
          ),
      AppRoutes.details: (BuildContext context) =>
          BlocProvider<DetailMovieBloc>(
            child: const DetailPage(),
            create: (context) => DetailMovieBloc(
                castMovieRemoteUseCase: getItApp<GetCastMovieRemoteUsecase>()),
          ), */
    };
  }

  static BlocProvider<T> getInstanceBloc<T extends BlocBase<dynamic>>(
      BuildContext context,
      {Widget? widget}) {
    return BlocProvider<T>.value(
      value: BlocProvider.of<T>(context),
      child: widget,
    );
  }

  static void navigateWithBloc<T extends BlocBase<dynamic>>(
      BuildContext context, Widget widget) {
    Navigator.push<T>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext contextBuild) {
          return getInstanceBloc<T>(context, widget: widget);
        },
      ),
    );
  }

  static void navigateAndReplaceWithBloc<T extends BlocBase<dynamic>>(
      BuildContext context, Widget widget) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext contextBuild) {
          return getInstanceBloc<T>(context, widget: widget);
        },
      ),
    );
  }

  static void navigateMultiBloc(BuildContext context, Widget widget,
      List<BlocProvider<dynamic>> blocProviderList) {
    Navigator.push<MultiBlocProvider>(
      context,
      MaterialPageRoute<MultiBlocProvider>(
        builder: (BuildContext contextBuild) {
          return MultiBlocProvider(
            providers: blocProviderList,
            child: widget,
          );
        },
      ),
    );
  }
}
