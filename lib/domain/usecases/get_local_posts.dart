import 'package:breeze/domain/entities/local_post.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/utils/failure.dart';
import 'package:breeze/utils/no_params.dart';
import 'package:breeze/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetLocalPosts implements UseCase<List<LocalPost>, NoParams> {
  final LocalUserRepository _localRepo;
  const GetLocalPosts(this._localRepo);
  @override
  Future<Either<Failure, List<LocalPost>>> call(NoParams params) {
    return _localRepo.getLocalPosts();
  }
}
