import 'package:flutter_marvel_dev/app/core/usecase/usecase.dart';

abstract class Command<Type, Params> extends UseCase<Type, Params> {
  bool readonly = false;
}
