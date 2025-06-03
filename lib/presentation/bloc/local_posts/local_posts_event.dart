part of 'local_posts_bloc.dart';

@immutable
sealed class LocalPostsEvent {}

final class LocalPostsFetchEvent extends LocalPostsEvent {}

final class LocalPostsAddEvent extends LocalPostsEvent {
  final LocalPost post;
  LocalPostsAddEvent(this.post);
}

final class LocalPostsDeleteEvent extends LocalPostsEvent {
  final String postId;
  LocalPostsDeleteEvent(this.postId);
}
