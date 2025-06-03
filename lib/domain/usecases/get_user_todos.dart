import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/is_device_online.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetUserTodos implements UseCase<List<Todo>, GetUserTodosParams> {
  final UserRepository _repo;
  final LocalUserRepository _localRepo;
  GetUserTodos(this._repo, this._localRepo);
  @override
  Future<Either<Failure, List<Todo>>> call(GetUserTodosParams params) async {
    final isOnline = await isDeviceOnline();
    if (!isOnline) {
      return _localRepo.getUserTodos(userId: params.userId);
    }
    final response = await _repo.getUserTodos(userId: params.userId);
    return response.fold((failure) => Left(failure), (todos) async {
      final cache = await _localRepo.cacheUserTodos(todos);
      if (cache.isLeft()) {
        cache.fold((failure) {
          // Handle caching failure if needed
        }, (success) {});
      }
      return Right(todos);
    });
  }
}

class GetUserTodosParams {
  final String userId;

  GetUserTodosParams({required this.userId});
}
