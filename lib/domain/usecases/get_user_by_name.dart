import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetUserByName implements UseCase<List<User>, GetUserByNameParams> {
  final UserRepository _repo;
  GetUserByName(this._repo);
  @override
  Future<Either<Failure, List<User>>> call(GetUserByNameParams params) {
    return _repo.getUserByName(name: params.name);
  }
}

class GetUserByNameParams {
  final String name;

  GetUserByNameParams({required this.name});
}
