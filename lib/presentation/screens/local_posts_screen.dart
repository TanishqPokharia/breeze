import 'package:breeze/presentation/bloc/local_posts/local_posts_bloc.dart';
import 'package:breeze/presentation/widgets/add_post_sheet.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalPostsScreen extends StatelessWidget {
  const LocalPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<LocalPostsBloc>().add(LocalPostsFetchEvent());
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Local Posts"), centerTitle: true),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                builder: (context) {
                  return AddPostSheet();
                },
              );
            },
            child: Icon(Icons.add),
          ),
          body: BlocConsumer<LocalPostsBloc, LocalPostsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LocalPostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocalPostsFailure) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is LocalPostsSuccess) {
                final posts = state.posts;
                if (posts.isEmpty) {
                  return const Center(child: Text("No local posts found."));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: posts.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Dismissible(
                      key: Key(post.id.toString()),
                      background: Container(
                        color: context.theme.colorScheme.error,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.delete, color: Colors.white),
                            const Icon(Icons.delete, color: Colors.white),
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        context.read<LocalPostsBloc>().add(
                          LocalPostsDeleteEvent(post.id.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: context.theme.colorScheme.primary,
                            content: Text("Post deleted successfully!"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: context.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          post.body,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
