import 'package:breeze/domain/entities/local_post.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class StoreLocalPost implements UseCase<void, StoreLocalPostParams> {
  final LocalUserRepository _repo;
  const StoreLocalPost(this._repo);
  @override
  Future<Either<Failure, void>> call(StoreLocalPostParams params) {
    return _repo.storeLocalPost(params.post);
  }
}

class StoreLocalPostParams {
  final LocalPost post;
  StoreLocalPostParams({required this.post});
}
