part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class FetchTodosEvent extends TodoEvent {
  final String userId;

  FetchTodosEvent({required this.userId});
}
