import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.todo, style: context.textTheme.titleMedium),
      subtitle: Row(
        spacing: 10,
        children: [
          Text(
            "Status: ${todo.completed ? 'Completed' : 'Pending'}",
            style: context.textTheme.titleSmall,
          ),
          todo.completed
              ? Icon(Icons.done, color: Colors.green)
              : Icon(Icons.pending, color: Colors.grey),
        ],
      ),
    );
  }
}
