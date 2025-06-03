import 'package:breeze/data/datasource/interfaces/user_datasource.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/http_client/interface/http_client.dart';
import 'package:dartz/dartz.dart';

class UserDatasourceImpl implements UserDataSource {
  final HttpClient _http;
  const UserDatasourceImpl(this._http);
  @override
  Future<Either<Failure, Map<String, dynamic>>> getAllUsers({
    required int limit,
    required int skip,
  }) async {
    final response = await _http.get(
      "https://dummyjson.com/users",
      queryParameters: {"limit": limit, "skip": skip},
    );

    return response.fold((failure) => Left(failure), (body) => Right(body));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserPosts({
    required String userId,
  }) async {
    final response = await _http.get(
      "https://dummyjson.com/posts/user/$userId",
    );
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserTodos({
    required String userId,
  }) async {
    final response = await _http.get(
      "https://dummyjson.com/todos/user/$userId",
    );
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserByName({
    required String name,
  }) async {
    final response = await _http.get(
      "https://dummyjson.com/users/search",
      queryParameters: {"q": name},
    );
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
