import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAllUsers({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, Map<String, dynamic>>> getUserPosts({
    required String userId,
  });

  Future<Either<Failure, Map<String, dynamic>>> getUserTodos({
    required String userId,
  });

  Future<Either<Failure, Map<String, dynamic>>> getUserByName({
    required String name,
  });
}
