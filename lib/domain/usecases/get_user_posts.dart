import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/is_device_online.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetUserPosts implements UseCase<List<Post>, GetUserPostsParams> {
  final UserRepository _repo;
  final LocalUserRepository _localRepo;

  GetUserPosts(this._repo, this._localRepo);
  @override
  Future<Either<Failure, List<Post>>> call(GetUserPostsParams params) async {
    final isOnline = await isDeviceOnline();
    if (!isOnline) {
      return _localRepo.getUserPosts(userId: params.userId);
    }
    final response = await _repo.getUserPosts(userId: params.userId);
    return response.fold((failure) => Left(failure), (posts) async {
      final cache = await _localRepo.cacheUserPosts(posts);
      if (cache.isLeft()) {
        cache.fold((failure) {}, (success) {});
      }
      return Right(posts);
    });
  }
}

class GetUserPostsParams {
  final String userId;

  GetUserPostsParams({required this.userId});
}
