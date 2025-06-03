import 'package:breeze/presentation/bloc/post/post_bloc.dart';
import 'package:breeze/presentation/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key, required this.userId});
  final String userId;

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchUserPostsEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostFailure) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is PostSuccess) {
          final posts = state.posts;
          if (posts.isEmpty) {
            return const Center(child: Text("No posts found."));
          }
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: posts.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostTile(post: post);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
