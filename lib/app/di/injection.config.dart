// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../core/infrastructure/remote/http/http_datasource_impl.dart' as _i5;
import '../core/infrastructure/remote_datasource.dart' as _i4;
import '../data/local/datasources/hive/config/datasource_hive_instance.dart'
    as _i3;
import '../data/remote/character/info_character_repository_remote.dart' as _i8;
import '../modules/home/application/querys/get_characters_usecase.dart' as _i9;
import '../modules/home/domain/repository/info_character_repository.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.DataSourceHiveInstance>(() => _i3.DataSourceHiveInstance());
  gh.factory<_i4.RemoteDataSource>(
    () => _i5.HttpDataSourceImpl(get<_i6.Client>()),
    instanceName: 'HTTP_DATASOURCE',
  );
  gh.factory<_i7.InfoCharacterRepository>(() =>
      _i8.InfoCharacterRepositoryRemoteImpl(
          get<_i4.RemoteDataSource>(instanceName: 'HTTP_DATASOURCE')));
  gh.factory<_i9.GetCharactersUseCase>(
      () => _i9.GetCharactersUseCase(get<_i7.InfoCharacterRepository>()));
  return get;
}
