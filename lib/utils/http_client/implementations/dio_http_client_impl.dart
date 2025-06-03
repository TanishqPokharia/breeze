import 'dart:developer';

import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/http_client/interface/http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DioHttpClientImpl implements HttpClient {
  final Dio _dio;
  const DioHttpClientImpl(this._dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await _dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      if (response.statusCode != 200) {
        log(response.data);
        return Left(
          Failure(message: "Failed to fetch data, Code:${response.statusCode}"),
        );
      }

      return Right(response.data);
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: "Failed to make request"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await _dio.post(
        url,
        options: options,
        data: body,
        queryParameters: queryParameters,
      );
      if (response.statusCode != 200) {
        log(response.data);
        return Left(
          Failure(message: "Failed to post data, Code:${response.statusCode}"),
        );
      }
      return Right(response.data);
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: "Failed to make request"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await _dio.put(
        url,
        options: options,
        data: body,
        queryParameters: queryParameters,
      );
      if (response.statusCode != 200) {
        log(response.data);
        return Left(
          Failure(
            message: "Failed to update data, Code:${response.statusCode}",
          ),
        );
      }
      return Right(response.data);
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: "Failed to make request"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await _dio.delete(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      if (response.statusCode != 200) {
        log(response.data);
        return Left(
          Failure(
            message: "Failed to delete data, Code:${response.statusCode}",
          ),
        );
      }
      return Right(response.data);
    } catch (e) {
      log(e.toString());
      return Left(Failure(message: "Failed to make request"));
    }
  }
}
