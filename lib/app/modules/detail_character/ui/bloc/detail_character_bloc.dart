import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/application/querys/get_comics_of_character_usecase.dart';
import 'package:flutter_marvel_dev/app/modules/detail_character/ui/bloc/detail_character_state.dart';

class DetailCharacterBloc extends Cubit<DetailCharacterState> {
  DetailCharacterBloc({required this.getComicsOfCharacterUseCase})
      : super(DetailCharacterState.init()) {
    init();
  }

  final GetComicsOfCharacterUseCase getComicsOfCharacterUseCase;

  int offset = 0;

  // =================================================================
  Future<void> init() async {
    /* emit(HomeState.loading());
    final data = await executeGetInfoCharacters();
    listDom.sink(data);
    if (state is! HomeErrorState) emit(HomeState.success()); */
  }

  void emitState(DetailCharacterState state) => emit(state);

  @override
  Future<void> close() {
    return super.close();
  }
}
