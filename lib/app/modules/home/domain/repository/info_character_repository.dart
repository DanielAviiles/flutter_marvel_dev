import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';

abstract class InfoCharacterRepository {
  Future<Either<Failure, List<InfoCharacterDom>>>? getCharacters(
      {int offset = 0});
  Future<Either<Failure, InfoCharacterDom>>? getCharacter(String nameHero);
}
