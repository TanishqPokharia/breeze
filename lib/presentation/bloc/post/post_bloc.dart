import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/domain/usecases/get_user_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetUserPosts _getUserPosts;
  PostBloc(this._getUserPosts) : super(PostInitial()) {
    on<FetchUserPostsEvent>((event, emit) async {
      emit(PostLoading());

      final posts = await _getUserPosts(
        GetUserPostsParams(userId: event.userId),
      );

      posts.fold(
        (failure) => emit(PostFailure(message: failure.message)),
        (posts) => emit(PostSuccess(posts: posts)),
      );
    });
  }
}
