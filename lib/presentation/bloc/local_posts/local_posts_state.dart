part of 'local_posts_bloc.dart';

@immutable
sealed class LocalPostsState {}

final class LocalPostsInitial extends LocalPostsState {}

final class LocalPostsLoading extends LocalPostsState {}

final class LocalPostsFailure extends LocalPostsState {
  final String message;

  LocalPostsFailure(this.message);
}

final class LocalPostsSuccess extends LocalPostsState {
  final List<LocalPost> posts;
  final String? message;
  LocalPostsSuccess({required this.posts, this.message});
}
