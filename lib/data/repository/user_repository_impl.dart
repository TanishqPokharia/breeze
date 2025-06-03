import 'package:breeze/data/datasource/interfaces/user_datasource.dart';
import 'package:breeze/data/models/post.dart';
import 'package:breeze/data/models/todo.dart';
import 'package:breeze/data/models/user.dart';
import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  const UserRepositoryImpl(this._dataSource);
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
}
