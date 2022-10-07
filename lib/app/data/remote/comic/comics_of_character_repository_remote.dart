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
import 'package:flutter_marvel_dev/app/data/models/comic/comic_model.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/domain/repository/comics_of_character_repository.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ComicsOfCharacterRepository)
class ComicsOfCharacterRepositoryRemoteImpl
    implements ComicsOfCharacterRepository {
  ComicsOfCharacterRepositoryRemoteImpl(
      @Named(RemoteDataSourceTypes.HTTP_DATASOURCE) this._api);

  final RemoteDataSource _api;

  @override
  Future<Either<Failure, List<InfoComicDom>>>? getComics(
      ParamsRequestModel params) async {
    try {
      String endPoint = '${params.endPoint!}?limit=10';
      endPoint +=
          '&offset=${params.offset}&apikey=${ApiRouteConfig.publicApiKey}&ts=1';
      endPoint += '&hash=${ApiRouteConfig.hashConf}';
      final response = await _api.get(enpoint: endPoint, timeOutSec: 5);
      if (response.body != null) {
        final apiGlobalModel = ApiGlobalModel.fromJson(response.body!);
        final listComicsModel =
            ComicModel.listFromJson(apiGlobalModel.data['results'] as List);
        final listInfoComics = listComicsModel
            .map((e) => InfoComicDom(
                  id: e.id,
                  title: e.titleComic,
                  description: e.descriptionComic ?? '',
                  imgUrl: e.urlImg,
                ))
            .toList();
        return Right<Failure, List<InfoComicDom>>(listInfoComics);
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
