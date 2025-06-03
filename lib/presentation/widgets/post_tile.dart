import 'package:breeze/domain/entities/post.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post});

  final Post post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => setState(() => isExpanded = !isExpanded),
      title: Text(widget.post.title, style: context.textTheme.titleMedium),
      isThreeLine: true,
      subtitle: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.body,
            style: context.textTheme.bodyMedium,
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          if (!isExpanded)
            Text(
              "Tap to read more",
              style: context.textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
            ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children:
                widget.post.tags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.thumb_up, color: Colors.blue, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.post.reactions.likes}",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.thumb_down, color: Colors.red, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.post.reactions.dislikes}",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.trending_up, color: Colors.grey, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.post.views}",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
