import 'package:breeze/data/datasource/interfaces/local_user_datasource.dart';
import 'package:breeze/data/models/local_post.dart';
import 'package:breeze/data/models/post.dart';
import 'package:breeze/data/models/todo.dart';
import 'package:breeze/data/models/user.dart';
import 'package:breeze/domain/entities/local_post.dart';
import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SqfliteLocalUserRepositoryImpl implements LocalUserRepository {
  final LocalUserDataSource _dataSource;
  const SqfliteLocalUserRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, void>> cacheUserPosts(List<Post> posts) async {
    try {
      final encodedPosts =
          posts.map((post) => (post as PostModel).toJson()).toList();
      final response = await _dataSource.cacheUserPosts(encodedPosts);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUserTodos(List<Todo> todos) async {
    try {
      final encodedTodos =
          todos.map((todo) => (todo as TodoModel).toJson()).toList();
      final response = await _dataSource.cacheUserTodos(encodedTodos);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUsers(List<User> users) async {
    try {
      final encodedUsers =
          users.map((user) => (user as UserModel).toJson()).toList();
      final response = await _dataSource.cacheUsers(encodedUsers);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await _dataSource.getAllUsers(limit: limit, skip: skip);
      return response.fold((failure) => Left(failure), (body) {
        final usersList = body['users'] as List<dynamic>;
        final users =
            usersList.map((user) => UserModel.fromJson(user)).toList();
        return Right(users);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getUserPosts({
    required String userId,
  }) async {
    try {
      final response = await _dataSource.getUserPosts(userId: userId);
      return response.fold((failure) => Left(failure), (body) {
        final postsList = body['posts'] as List<dynamic>;
        final posts =
            postsList.map((post) => PostModel.fromJson(post)).toList();
        return Right(posts);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getUserTodos({
    required String userId,
  }) async {
    try {
      final response = await _dataSource.getUserTodos(userId: userId);
      return response.fold((failure) => Left(failure), (body) {
        final todosList = body['todos'] as List<dynamic>;
        final todos =
            todosList.map((todo) => TodoModel.fromJson(todo)).toList();
        return Right(todos);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUserByName({
    required String name,
  }) async {
    try {
      final response = await _dataSource.getUserByName(name: name);
      return response.fold((failure) => Left(failure), (body) {
        final usersList = body['users'] as List<dynamic>;
        final users =
            usersList.map((user) => UserModel.fromJson(user)).toList();
        return Right(users);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocalPost>>> getLocalPosts() async {
    try {
      final response = await _dataSource.getLocalPosts();
      return response.fold((failure) => Left(failure), (posts) {
        final localPosts =
            posts.map((post) => LocalPostModel.fromJson(post)).toList();
        return Right(localPosts);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeLocalPost(LocalPost post) async {
    try {
      final encodedPost = (post as LocalPostModel).toJson();
      final response = await _dataSource.storeLocalPost(encodedPost);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocalPost(String postId) async {
    try {
      final response = await _dataSource.deleteLocalPost(postId);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
