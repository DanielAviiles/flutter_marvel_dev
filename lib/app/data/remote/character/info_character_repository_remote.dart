import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/api/api_route_config.dart';
import 'package:flutter_marvel_dev/app/core/constant/server_constant.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/core/exceptions/exceptions.dart';
import 'package:flutter_marvel_dev/app/core/infrastructure/remote_datasource.dart';
import 'package:flutter_marvel_dev/app/core/infrastructure/remote_datasource_types.dart';
import 'package:flutter_marvel_dev/app/core/models/api_global_model.dart';
import 'package:flutter_marvel_dev/app/data/models/character/character_model.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/repository/info_character_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: InfoCharacterRepository)
class InfoCharacterRepositoryRemoteImpl implements InfoCharacterRepository {
  InfoCharacterRepositoryRemoteImpl(
      @Named(RemoteDataSourceTypes.HTTP_DATASOURCE) this._api);

  final RemoteDataSource _api;

  @override
  Future<Either<Failure, List<InfoCharacterDom>>>? getCharacters(
      ParamsRequestModel modelParams) async {
    try {
      String endPoint = '${ApiRouteConfig.baseUrl}/characters?limit=10';
      if (modelParams.name.isNotEmpty) {
        endPoint += '&name=${modelParams.name.replaceAll(RegExp(r' '), '%20')}';
      }
      endPoint +=
          '&offset=${modelParams.offset}&apikey=${ApiRouteConfig.publicApiKey}&ts=1';
      endPoint += '&hash=${ApiRouteConfig.hashConf}';
      final response = await _api.get(enpoint: endPoint, timeOutSec: 5);
      if (response.body != null) {
        final apiGlobalModel = ApiGlobalModel.fromJson(response.body!);
        final listCharacterModel =
            CharacterModel.listFromJson(apiGlobalModel.data['results'] as List);
        final listInfoCharacterDom = listCharacterModel
            .map((e) => InfoCharacterDom(
                  id: e.id,
                  name: e.nameHero,
                  description: e.descriptionHero ?? '',
                  imgUrl: e.urlImg,
                  relatedComics: e.urlReleatedComics,
                ))
            .toList();
        return Right<Failure, List<InfoCharacterDom>>(listInfoCharacterDom);
      }
      return Failure.error(
        ServerConstant.unknowError,
        'unknowError: ${response.message}',
        ex: UnknowException('unknowError: ${response.message}', null),
      );
    } on TimeoutException catch (_) {
      return Failure.error(ServerConstant.timeOutException, _.message, ex: _);
    } on SocketException catch (_) {
      return Failure.error(ServerConstant.socketException, _.message, ex: _);
    } on ApiException catch (_) {
      return Failure.error(
          _.getErrorApi()?.messageKey, _.getErrorApi()?.message,
          ex: _);
    } catch (e) {
      return Failure.error(ServerConstant.unknowError, e.toString(),
          ex: UnknowException(e.toString(), null));
    }
  }
}
