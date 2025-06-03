import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LocalUserDataSource {
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

  Future<Either<Failure, void>> cacheUsers(List<Map<String, dynamic>> users);
  Future<Either<Failure, void>> cacheUserPosts(
    List<Map<String, dynamic>> posts,
  );
  Future<Either<Failure, void>> cacheUserTodos(
    List<Map<String, dynamic>> todos,
  );

  Future<Either<Failure, List<Map<String, dynamic>>>> getLocalPosts();
  Future<Either<Failure, void>> storeLocalPost(Map<String, dynamic> post);
  Future<Either<Failure, void>> deleteLocalPost(String postId);
}
