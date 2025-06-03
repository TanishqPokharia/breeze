import 'dart:developer';

import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/is_device_online.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllUsers implements UseCase<List<User>, GetAllUsersParams> {
  final UserRepository _repo;
  final LocalUserRepository _localRepo;
  const GetAllUsers(this._repo, this._localRepo);
  @override
  Future<Either<Failure, List<User>>> call(GetAllUsersParams params) async {
    final isOnline = await isDeviceOnline();
    if (!isOnline) {
      return _localRepo.getAllUsers(limit: params.limit, skip: params.skip);
    }

    final response = await _repo.getAllUsers(
      limit: params.limit,
      skip: params.skip,
    );

    return response.fold((failure) => Left(failure), (users) async {
      final cache = await _localRepo.cacheUsers(users);
      if (cache.isLeft()) {
        cache.fold((failure) {
          log(failure.message);
        }, (success) {});
      }
      return Right(users);
    });
  }
}

class GetAllUsersParams {
  final int limit;
  final int skip;

  const GetAllUsersParams({required this.limit, required this.skip});
}
