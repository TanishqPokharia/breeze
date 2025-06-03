import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Success, Params> {
  Future<Either<Failure, Success>> call(Params params);
}
