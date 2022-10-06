import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/core/bloc/generic_field_bloc.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/home/application/querys/get_characters_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/home/ui/bloc/home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc({required this.getCharactersUseCase}) : super(HomeState.init()) {
    init();
  }

  final GetCharactersUseCase getCharactersUseCase;
  int offset = 0;
  GenericFieldBloc<List<InfoCharacterDom>> listDom =
      GenericFieldBloc<List<InfoCharacterDom>>(
          defaultValue: <InfoCharacterDom>[]);
  ParamsRequestModel modelParams = ParamsRequestModel();

  // =================================================================
  Future<void> init() async {
    emit(HomeState.loading());
    final data = await executeGetInfoCharacters();
    listDom.sink(data);
    if (state is! HomeErrorState) emit(HomeState.success());
  }

  void emitState(HomeState state) => emit(state);

  void scrollControllerListener(ScrollController scrollController) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      await infiniteScrollCharacters();
    }
  }

  Future<List<InfoCharacterDom>> executeGetInfoCharacters() async {
    List<InfoCharacterDom> listCharacters = <InfoCharacterDom>[];
    final response = await getCharactersUseCase.execute(modelParams);
    response?.foldRight(List<InfoCharacterDom>,
        (List<InfoCharacterDom> value, Object? previous) {
      listCharacters.addAll(value);
    });
    if (response?.isLeft() ?? false) {
      emit(HomeState.error());
    }
    return listCharacters;
  }

  Future<void> infiniteScrollCharacters() async {
    offset += 1;
    modelParams = modelParams.copyWith(offset: offset);
    final tempNewList = await executeGetInfoCharacters();
    listDom.value!.addAll(tempNewList);
    listDom.sink(listDom.value);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
