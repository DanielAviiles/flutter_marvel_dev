import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/core/usecase/query.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/repository/info_character_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCharactersUseCase
    extends Query<Either<Failure, List<InfoCharacterDom>>, int> {
  GetCharactersUseCase(this.infoCharacterRepository);
  final InfoCharacterRepository infoCharacterRepository;
  @override
  Future<Either<Failure, List<InfoCharacterDom>>?> execute(int params) async =>
      infoCharacterRepository.getCharacters(offset: params);
}
