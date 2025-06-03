import 'dart:convert';
import 'dart:developer';

import 'package:breeze/data/datasource/interfaces/local_user_datasource.dart';
import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteLocalDatasourceImpl implements LocalUserDataSource {
  late final Database _database;
  SqfliteLocalDatasourceImpl(this._database);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAllUsers({
    required int limit,
    required int skip,
  }) async {
    try {
      final List<Map<String, dynamic>> users = await _database.query(
        'users',
        limit: limit,
        offset: skip,
      );
      return Right({"users": users});
    } catch (e) {
      return Left(Failure(message: "Failed to fetch users"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserByName({
    required String name,
  }) async {
    try {
      final List<Map<String, dynamic>> users = await _database.query(
        'users',
        where: 'firstName LIKE ? OR lastName LIKE ?',
        whereArgs: ['%$name%', '%$name%'],
      );

      return Right({"users": users});
    } catch (e) {
      return Left(Failure(message: "Failed to fetch user by name"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserPosts({
    required String userId,
  }) async {
    try {
      final List<Map<String, dynamic>> posts = await _database.query(
        'posts',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      final mappedPosts =
          posts
              .map(
                (post) => {
                  "id": post['id'],
                  "userId": post['userId'],
                  "title": post['title'],
                  "body": post['body'],
                  "views": post['views'],
                  "tags": post['tags'].split(','),
                  "reactions": jsonDecode(post['reactions']),
                },
              )
              .toList();
      return Right({"posts": mappedPosts});
    } catch (e) {
      return Left(Failure(message: "Failed to fetch user posts"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserTodos({
    required String userId,
  }) async {
    try {
      final List<Map<String, dynamic>> todos = await _database.query(
        'todos',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      final mappedTodos =
          todos
              .map(
                (todo) => {
                  "id": todo['id'],
                  "todo": todo['todo'],
                  "completed": todo['completed'] == 1,
                  "userId": todo['userId'],
                },
              )
              .toList();
      return Right({"todos": mappedTodos});
    } catch (e) {
      return Left(Failure(message: "Failed to fetch user todos"));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUsers(
    List<Map<String, dynamic>> users,
  ) async {
    try {
      final batch = _database.batch();
      for (final user in users) {
        batch.insert(
          'users',
          user,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
      return const Right(null);
    } catch (e) {
      log("Failed to cache users", error: e);
      return Left(Failure(message: "Failed to cache users"));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUserPosts(
    List<Map<String, dynamic>> posts,
  ) async {
    try {
      final batch = _database.batch();
      for (final post in posts) {
        batch.insert('posts', {
          "id": post['id'],
          "userId": post['userId'],
          "title": post['title'],
          "body": post['body'],
          "views": post['views'],
          "tags": post['tags'].join(','),
          "reactions": jsonEncode(post['reactions']),
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: "Failed to cache user posts"));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUserTodos(
    List<Map<String, dynamic>> todos,
  ) async {
    try {
      final batch = _database.batch();
      for (final todo in todos) {
        batch.insert('todos', {
          "id": todo['id'],
          "todo": todo['todo'],
          "completed": todo['completed'] ? 1 : 0,
          "userId": todo['userId'],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: "Failed to cache user todos"));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getLocalPosts() async {
    try {
      final List<Map<String, dynamic>> posts = await _database.query(
        'user_posts',
      );
      return Right(posts);
    } catch (e) {
      log("Failed to fetch local posts", error: e);
      return Left(Failure(message: "Failed to fetch local posts"));
    }
  }

  @override
  Future<Either<Failure, void>> storeLocalPost(
    Map<String, dynamic> post,
  ) async {
    try {
      await _database.insert(
        'user_posts',
        post,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return const Right(null);
    } catch (e) {
      log("Failed to store local post", error: e);
      return Left(Failure(message: "Failed to store local post"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocalPost(String postId) async {
    try {
      await _database.delete(
        'user_posts',
        where: 'id = ?',
        whereArgs: [postId],
      );
      return const Right(null);
    } catch (e) {
      log("Failed to delete local post", error: e);
      return Left(Failure(message: "Failed to delete local post"));
    }
  }
}
