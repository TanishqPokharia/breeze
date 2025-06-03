import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAllUsers({
    required int limit,
    required int skip,
  });
  Future<Either<Failure, List<Post>>> getUserPosts({required String userId});
  Future<Either<Failure, List<Todo>>> getUserTodos({required String userId});
  Future<Either<Failure, List<User>>> getUserByName({required String name});
}
