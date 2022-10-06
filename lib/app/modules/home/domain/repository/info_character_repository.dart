import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';

abstract class InfoCharacterRepository {
  Future<Either<Failure, List<InfoCharacterDom>>>? getCharacters(
      ParamsRequestModel modelParams);
}
