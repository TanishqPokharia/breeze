import 'package:breeze/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HttpClient {
  Future<Either<Failure, Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Map<String, dynamic>>> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
