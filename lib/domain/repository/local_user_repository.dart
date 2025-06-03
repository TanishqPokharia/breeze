import 'package:breeze/domain/entities/local_post.dart';
import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LocalUserRepository {
  Future<Either<Failure, List<User>>> getAllUsers({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, List<Post>>> getUserPosts({required String userId});

  Future<Either<Failure, List<Todo>>> getUserTodos({required String userId});

  Future<Either<Failure, List<User>>> getUserByName({required String name});

  Future<Either<Failure, void>> cacheUsers(List<User> users);

  Future<Either<Failure, void>> cacheUserPosts(List<Post> posts);

  Future<Either<Failure, void>> cacheUserTodos(List<Todo> todos);
  Future<Either<Failure, List<LocalPost>>> getLocalPosts();
  Future<Either<Failure, void>> storeLocalPost(LocalPost post);
  Future<Either<Failure, void>> deleteLocalPost(String postId);
}
