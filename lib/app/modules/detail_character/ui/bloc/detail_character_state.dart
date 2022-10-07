class DetailCharacterState {
  DetailCharacterState();
  factory DetailCharacterState.init() => DetailCharacterInitState();
  factory DetailCharacterState.loading() => DetailCharacterLoadingState();
  factory DetailCharacterState.success() => DetailCharacterSuccessState();
  factory DetailCharacterState.error() => DetailCharacterErrorState();
}

class DetailCharacterInitState extends DetailCharacterState {
  DetailCharacterInitState() : super();
}

class DetailCharacterLoadingState extends DetailCharacterState {
  DetailCharacterLoadingState() : super();
}

class DetailCharacterSuccessState extends DetailCharacterState {
  DetailCharacterSuccessState() : super();
}

class DetailCharacterErrorState extends DetailCharacterState {
  DetailCharacterErrorState() : super();
}