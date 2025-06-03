import 'package:breeze/data/models/reaction.dart';
import 'package:breeze/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.tags,
    required super.reactions,
    required super.views,
    required super.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tags: List<String>.from(json['tags'] ?? []),
      reactions: ReactionsModel.fromJson(json['reactions']),
      views: json['views'] ?? 0,
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': (reactions as ReactionsModel).toJson(),
      'views': views,
      'userId': userId,
    };
  }
}
