import 'package:breeze/domain/entities/reactions.dart';

class ReactionsModel extends Reactions {
  ReactionsModel({required super.likes, required super.dislikes});

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'likes': likes, 'dislikes': dislikes};
  }

  ReactionsModel copyWith({int? likes, int? dislikes}) {
    return ReactionsModel(
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
    );
  }
}
