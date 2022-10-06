class SearchState {
  SearchState();
  factory SearchState.init() => SearchInitState();
  factory SearchState.loading() => SearchLoadingState();
  factory SearchState.success() => SearchSuccessState();
  factory SearchState.error() => SearchErrorState();
}

class SearchInitState extends SearchState {
  SearchInitState() : super();
}

class SearchLoadingState extends SearchState {
  SearchLoadingState() : super();
}

class SearchSuccessState extends SearchState {
  SearchSuccessState() : super();
}

class SearchErrorState extends SearchState {
  SearchErrorState() : super();
}