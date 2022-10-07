import 'package:flutter_marvel_dev/app/modules/detail_character/application/querys/get_comics_of_character_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/domain/repository/comics_of_character_repository.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/home/application/querys/get_characters_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/repository/info_character_repository.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/bloc/home_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as client;
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final GetIt getItApp = GetIt.instance;

@injectableInit
void configureAppInjection() {
  unregisterServices();
  registerCustoms();
  $initGetIt(getItApp);
}

void registerCustoms() {
  getItApp.registerLazySingleton(() => client.Client());
  getItApp
      .registerLazySingleton(() => HomeBloc(getCharactersUseCase: getItApp()));
  getItApp.registerLazySingleton(
      () => SearchBloc(getCharactersUseCase: getItApp()));
  getItApp.registerLazySingleton(
      () => DetailCharacterBloc(getComicsOfCharacterUseCase: getItApp()));
}

void unregisterServices() {
  // REPOSITORY
  removeRegistrationIfExists<InfoCharacterRepository>();
  removeRegistrationIfExists<ComicsOfCharacterRepository>();

  // USESCASES
  removeRegistrationIfExists<GetCharactersUseCase>();
  removeRegistrationIfExists<GetComicsOfCharacterUseCase>();
}

void removeRegistrationIfExists<T extends Object>({String? instanceName}) {
  if (getItApp.isRegistered<T>(instanceName: instanceName)) {
    getItApp.unregister<T>(instanceName: instanceName);
  }
}
