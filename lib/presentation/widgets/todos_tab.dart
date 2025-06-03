import 'package:breeze/presentation/bloc/todo/todo_bloc.dart';
import 'package:breeze/presentation/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosTab extends StatefulWidget {
  const TodosTab({super.key, required this.userId});
  final String userId;

  @override
  State<TodosTab> createState() => _TodosTabState();
}

class _TodosTabState extends State<TodosTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FetchTodosEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoFailure) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is TodoSuccess) {
          final todos = state.todos;
          if (todos.isEmpty) {
            return const Center(child: Text("No todos found."));
          }
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: todos.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoTile(todo: todo);
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
