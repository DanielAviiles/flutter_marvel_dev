import 'package:flutter_marvel_dev/app/core/usecase/usecase.dart';

abstract class Query<Type, Params> extends UseCase<Type, Params> {
  bool readonly = true;
}

class NoParams {
  List<Object> get props => [];
}
