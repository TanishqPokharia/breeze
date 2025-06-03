part of 'userlist_bloc.dart';

@immutable
sealed class UserListState {}

final class UserListInitial extends UserListState {}

final class UserListLoading extends UserListState {}

final class UserListFailure extends UserListState {
  final String message;

  UserListFailure(this.message);
}

final class UserListByNameSuccess extends UserListState {
  final List<User> users;
  final String? message;

  UserListByNameSuccess({required this.users, this.message});
}

final class UserListSuccess extends UserListState {
  final List<User> users;
  final String? message;

  UserListSuccess({required this.users, this.message});
}
