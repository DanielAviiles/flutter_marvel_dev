import 'package:dartz/dartz.dart';
import 'package:flutter_marvel_dev/app/core/errors/failure.dart';
import 'package:flutter_marvel_dev/app/core/usecase/query.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/domain/repository/comics_of_character_repository.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetComicsOfCharacterUseCase
    extends Query<Either<Failure, List<InfoComicDom>>, ParamsRequestModel> {
  GetComicsOfCharacterUseCase(this.comicsOfCharacterRepository);
  final ComicsOfCharacterRepository comicsOfCharacterRepository;
  @override
  Future<Either<Failure, List<InfoComicDom>>?> execute(
          ParamsRequestModel params) async =>
      comicsOfCharacterRepository.getComics(params);
}
