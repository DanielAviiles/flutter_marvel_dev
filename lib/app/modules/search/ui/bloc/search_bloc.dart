import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/core/bloc/generic_field_bloc.dart';
import 'package:flutter_marvel_dev/app/data/models/params_request/params_request_model.dart';
import 'package:flutter_marvel_dev/app/modules/home/application/querys/get_characters_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';
import 'package:flutter_marvel_dev/app/modules/search/ui/bloc/search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc({required this.getCharactersUseCase}) : super(SearchState.init());

  final GetCharactersUseCase getCharactersUseCase;
  int offset = 0;
  GenericFieldBloc<List<InfoCharacterDom>> listDom =
      GenericFieldBloc<List<InfoCharacterDom>>(
          defaultValue: <InfoCharacterDom>[]);
  ParamsRequestModel modelParams = ParamsRequestModel();

  // =================================================================

  void emitState(SearchState state) => emit(state);

  void scrollControllerListener(ScrollController scrollController) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      await infiniteScrollCharacters();
    }
  }

  Future<List<InfoCharacterDom>> executeSearchGetInfoCharacter(
      {String value = ''}) async {
    List<InfoCharacterDom> listCharacters = <InfoCharacterDom>[];
    if (value.isNotEmpty) modelParams = modelParams.copyWith(name: value);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final response = await getCharactersUseCase.execute(modelParams);
    response?.foldRight(List<InfoCharacterDom>,
        (List<InfoCharacterDom> value, Object? previous) {
      listCharacters.addAll(value);
    });
    if (response?.isLeft() ?? false) {
      emit(SearchState.error());
    }
    return listCharacters;
  }

  Future<void> infiniteScrollCharacters() async {
    offset += 10;
    modelParams = modelParams.copyWith(offset: offset);
    final tempNewList = await executeSearchGetInfoCharacter();
    listDom.value!.addAll(tempNewList);
    listDom.sink(listDom.value);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
