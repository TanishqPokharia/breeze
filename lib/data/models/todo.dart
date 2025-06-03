import 'package:breeze/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'] ?? false,

      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'todo': todo, 'completed': completed, 'userId': userId};
  }
}
