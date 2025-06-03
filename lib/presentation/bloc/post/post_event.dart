part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class FetchUserPostsEvent extends PostEvent {
  final String userId;

  FetchUserPostsEvent({required this.userId});
}
