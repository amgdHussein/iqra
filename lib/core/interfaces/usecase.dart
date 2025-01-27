import 'dart:async';

import 'package:dartz/dartz.dart';

import 'failure.dart';

abstract class UseCase<Type, Params> {
  FutureOr<Either<Failure, Type>> call(Params params);
}
