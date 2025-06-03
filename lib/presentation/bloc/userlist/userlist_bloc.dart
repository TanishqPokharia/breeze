import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/domain/usecases/get_all_users.dart';
import 'package:breeze/domain/usecases/get_user_by_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'userlist_event.dart';
part 'userlist_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetAllUsers _getAllUsers;
  final GetUserByName _getUserByName;
  UserListBloc(this._getAllUsers, this._getUserByName)
    : super(UserListInitial()) {
    on<UserListFetchEvent>((event, emit) async {
      // if some users fetched before, append new users to previous list
      if (state is UserListSuccess) {
        final currentState = state as UserListSuccess;
        final users = await _getAllUsers(
          GetAllUsersParams(limit: event.limit, skip: event.skip),
        );
        users.fold(
          (failure) => emit(
            UserListSuccess(
              users: currentState.users,
              message: failure.message,
            ),
          ),
          (users) =>
              emit(UserListSuccess(users: [...currentState.users, ...users])),
        );
        return;
      }

      // handle initial fetch
      emit(UserListLoading());
      final users = await _getAllUsers(
        GetAllUsersParams(limit: event.limit, skip: event.skip),
      );
      users.fold(
        (failure) => emit(UserListFailure(failure.message)),
        (users) => emit(UserListSuccess(users: users)),
      );
    });

    on<UserListRefreshEvent>((event, emit) async {
      emit(UserListLoading());
      final users = await _getAllUsers(GetAllUsersParams(limit: 20, skip: 0));
      users.fold(
        (failure) => emit(UserListFailure(failure.message)),
        (users) => emit(UserListSuccess(users: users)),
      );
    });

    on<UserListSearchByNameEvent>((event, emit) async {
      emit(UserListLoading());
      final users = await _getUserByName(GetUserByNameParams(name: event.name));
      users.fold(
        (failure) => emit(UserListFailure(failure.message)),
        (users) => emit(UserListByNameSuccess(users: users)),
      );
    });
  }
}
