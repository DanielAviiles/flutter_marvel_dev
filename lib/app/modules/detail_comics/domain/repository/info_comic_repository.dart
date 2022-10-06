import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';

abstract class InfoComicRepository {
  Future<Either<Failure, List<InfoComicDom>>>? getCharacters();
  Future<Either<Failure, InfoComicDom>>? getCharacter(String id);
}
