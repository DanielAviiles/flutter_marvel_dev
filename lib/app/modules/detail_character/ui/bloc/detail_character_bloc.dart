import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/core/bloc/generic_field_bloc.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/application/querys/get_comics_of_character_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_state.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';

class DetailCharacterBloc extends Cubit<DetailCharacterState> {
  DetailCharacterBloc({required this.getComicsOfCharacterUseCase})
      : super(DetailCharacterState.init());

  final GetComicsOfCharacterUseCase getComicsOfCharacterUseCase;

  int offset = 0;
  GenericFieldBloc<List<InfoComicDom>> listDom =
      GenericFieldBloc<List<InfoComicDom>>(defaultValue: <InfoComicDom>[]);
  ParamsRequestModel params = ParamsRequestModel();
  ValueNotifier<bool> loadingElements = ValueNotifier<bool>(false);

  String endPointComicsOfCharacter = '';

  // =================================================================
  Future<void> init() async {
    emit(DetailCharacterState.loading());
    final data = await executeGetInfoComics();
    listDom.sink(data);
    if (state is! DetailCharacterErrorState)
      emit(DetailCharacterState.success());
  }

  Future<List<InfoComicDom>> executeGetInfoComics() async {
    List<InfoComicDom> responseList = <InfoComicDom>[];
    if (endPointComicsOfCharacter.isNotEmpty) {
      final response = await getComicsOfCharacterUseCase
          .execute(params.copyWith(endPoint: endPointComicsOfCharacter));
      response?.foldRight(List<InfoComicDom>,
          (List<InfoComicDom> value, Object? previous) {
        responseList.addAll(value);
      });
      if (response?.isLeft() ?? false) {
        emit(DetailCharacterState.error());
      }
      return responseList;
    }
    return responseList;
  }

  void scrollControllerListener(ScrollController scrollController) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      await infiniteScrollCharacters();
    }
  }

  Future<void> infiniteScrollCharacters() async {
    offset += 10;
    loadingElements.value = true;
    params = params.copyWith(offset: offset);
    final loadElements = await executeGetInfoComics();
    loadingElements.value = false;
    listDom.value!.addAll(loadElements);
    listDom.sink(listDom.value);
  }

  void emitState(DetailCharacterState state) => emit(state);

  @override
  Future<void> close() {
    return super.close();
  }
}
