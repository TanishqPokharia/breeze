import 'package:breeze/domain/entities/local_post.dart';

class LocalPostModel extends LocalPost {
  LocalPostModel({
    required super.id,
    required super.title,
    required super.body,
  });

  factory LocalPostModel.fromJson(Map<String, dynamic> json) {
    return LocalPostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}
