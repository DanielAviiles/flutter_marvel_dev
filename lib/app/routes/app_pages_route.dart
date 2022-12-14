import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/di/injection.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/application/querys/get_comics_of_character_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/detail_character_page.dart';
import 'package:flutter_marvel_dev/app/modules/home/application/querys/get_characters_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/bloc/home_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/home_page.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/bloc/search_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/search_page.dart';
import 'package:flutter_marvel_dev/app/routes/app_routes.dart';

mixin AppPagesRoute {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      AppRoutes.home: (BuildContext context) => BlocProvider<HomeBloc>(
            child: const HomePage(),
            create: (context) => HomeBloc(
              getCharactersUseCase: getItApp<GetCharactersUseCase>(),
            ),
          ),
      AppRoutes.searchHero: (BuildContext context) => BlocProvider<SearchBloc>(
            child: const SearchPage(),
            create: (context) => SearchBloc(
              getCharactersUseCase: getItApp<GetCharactersUseCase>(),
            ),
          ),
      AppRoutes.detailCharacter: (BuildContext context) =>
          BlocProvider<DetailCharacterBloc>(
            child: const DetailCharacterPage(),
            create: (context) => DetailCharacterBloc(
              getComicsOfCharacterUseCase:
                  getItApp<GetComicsOfCharacterUseCase>(),
            ),
          ),
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
