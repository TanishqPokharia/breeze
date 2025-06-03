part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoFailure extends TodoState {
  final String message;

  TodoFailure({required this.message});
}

final class TodoSuccess extends TodoState {
  final List<Todo> todos;

  TodoSuccess({required this.todos});
}
