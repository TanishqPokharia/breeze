part of 'userlist_bloc.dart';

@immutable
sealed class UserListEvent {}

final class UserListFetchEvent extends UserListEvent {
  final int limit;
  final int skip;
  UserListFetchEvent({required this.limit, required this.skip});
}

final class UserListRefreshEvent extends UserListEvent {}

final class UserListSearchByNameEvent extends UserListEvent {
  final String name;
  UserListSearchByNameEvent({required this.name});
}
