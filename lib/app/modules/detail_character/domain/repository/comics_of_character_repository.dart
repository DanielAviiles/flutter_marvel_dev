import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';

abstract class ComicsOfCharacterRepository {
  Future<Either<Failure, List<InfoComicDom>>>? getComics(
      ParamsRequestModel params);
}
