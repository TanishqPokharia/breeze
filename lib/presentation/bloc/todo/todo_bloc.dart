import 'package:breeze/domain/entities/todo.dart';
import 'package:breeze/domain/usecases/get_user_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetUserTodos _getUserTodos;
  TodoBloc(this._getUserTodos) : super(TodoInitial()) {
    on<FetchTodosEvent>((event, emit) async {
      emit(TodoLoading());
      final response = await _getUserTodos(
        GetUserTodosParams(userId: event.userId),
      );
      response.fold(
        (failure) => emit(TodoFailure(message: failure.message)),
        (todos) => emit(TodoSuccess(todos: todos)),
      );
    });
  }
}
