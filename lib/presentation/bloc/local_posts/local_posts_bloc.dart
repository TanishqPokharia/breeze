import 'package:breeze/domain/entities/local_post.dart';
import 'package:breeze/domain/usecases/delete_local_post.dart';
import 'package:breeze/domain/usecases/get_local_posts.dart';
import 'package:breeze/domain/usecases/store_local_post.dart';
import 'package:breeze/utils/no_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'local_posts_event.dart';
part 'local_posts_state.dart';

class LocalPostsBloc extends Bloc<LocalPostsEvent, LocalPostsState> {
  final GetLocalPosts _getLocalPosts;
  final StoreLocalPost _storeLocalPost;
  final DeleteLocalPost _deleteLocalPost;
  LocalPostsBloc(
    this._getLocalPosts,
    this._storeLocalPost,
    this._deleteLocalPost,
  ) : super(LocalPostsInitial()) {
    on<LocalPostsFetchEvent>((event, emit) async {
      emit(LocalPostsLoading());
      final response = await _getLocalPosts(NoParams());
      response.fold(
        (failure) => emit(LocalPostsFailure(failure.message)),
        (posts) => emit(LocalPostsSuccess(posts: posts)),
      );
    });

    on<LocalPostsAddEvent>((event, emit) async {
      // store the already fetched post
      List<LocalPost> loadedPosts = [];
      if (state is LocalPostsSuccess) {
        loadedPosts = [...(state as LocalPostsSuccess).posts];
      }

      emit(LocalPostsLoading());

      final response = await _storeLocalPost(
        StoreLocalPostParams(post: event.post),
      );
      response.fold(
        (failure) => emit(LocalPostsFailure(failure.message)),
        (_) => emit(LocalPostsSuccess(posts: loadedPosts..add(event.post))),
      );
    });

    on<LocalPostsDeleteEvent>((event, emit) async {
      final response = await _deleteLocalPost(
        DeleteLocalPostParams(postId: event.postId),
      );
      response.fold(
        (failure) {
          if (state is LocalPostsSuccess) {
            emit(
              LocalPostsSuccess(
                posts: (state as LocalPostsSuccess).posts,
                message: failure.message,
              ),
            );
          } else {
            emit(LocalPostsFailure(failure.message));
          }
        },
        (_) {
          if (state is LocalPostsSuccess) {
            final updatedPosts =
                (state as LocalPostsSuccess).posts
                    .where((post) => post.id.toString() != event.postId)
                    .toList();
            emit(LocalPostsSuccess(posts: updatedPosts));
          }
        },
      );
    });

    add(LocalPostsFetchEvent());
  }
}
