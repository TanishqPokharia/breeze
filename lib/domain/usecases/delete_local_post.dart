import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteLocalPost implements UseCase<void, DeleteLocalPostParams> {
  final LocalUserRepository _repo;
  const DeleteLocalPost(this._repo);
  @override
  Future<Either<Failure, void>> call(DeleteLocalPostParams params) {
    return _repo.deleteLocalPost(params.postId);
  }
}

class DeleteLocalPostParams {
  final String postId;

  const DeleteLocalPostParams({required this.postId});
}
