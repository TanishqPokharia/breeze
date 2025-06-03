import 'package:breeze/presentation/bloc/userlist/userlist_bloc.dart';
import 'package:breeze/presentation/cubit/theme/theme_cubit.dart';
import 'package:breeze/presentation/widgets/user_tile.dart';
import 'package:breeze/router/routes.dart';
import 'package:breeze/utils/debouncer.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int limit = 20;
  int skip = 0;
  bool isFetching = false;
  bool hasMoreData = true;
  final Debouncer _debouncer = Debouncer(delay: Durations.extralong1);

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchUsers();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isFetching &&
        hasMoreData) {
      _fetchUsers();
    }
  }

  void _fetchUsers() {
    isFetching = true;
    context.read<UserListBloc>().add(
      UserListFetchEvent(limit: limit, skip: skip),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          skip = 0;
          context.read<UserListBloc>().add(UserListRefreshEvent());
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Users'), centerTitle: true),
          drawer: Drawer(
            backgroundColor: context.theme.drawerTheme.backgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: context.colorScheme.primary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/breeze_logo.png', height: 80),
                      Text(
                        'Breeze',
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("My Posts", style: context.textTheme.bodyLarge),
                  onTap: () {
                    context.pushNamed(AppRoutes.userPostsRoute);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownMenu<ThemeMode>(
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                    ),
                    textStyle: context.textTheme.bodyLarge,
                    initialSelection:
                        (context.watch<ThemeCubit>().state as ThemeInitial)
                            .themeMode,
                    onSelected: (value) async {
                      if (value == null) return;
                      context.read<ThemeCubit>().changeTheme(value);
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<ThemeMode>>[
                      DropdownMenuEntry(
                        value: ThemeMode.light,
                        label: 'Light Theme',
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.dark,
                        label: 'Dark Theme',
                      ),
                      DropdownMenuEntry(
                        value: ThemeMode.system,
                        label: 'System Default',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(50),
                  child: TextField(
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        _debouncer.cancel();
                        return;
                      }
                      _debouncer.run(() {
                        context.read<UserListBloc>().add(
                          UserListSearchByNameEvent(name: value),
                        );
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Users',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<UserListBloc, UserListState>(
                  listener: (context, state) {
                    if (state is UserListSuccess) {
                      isFetching = false;

                      // If fetched less than limit, we’ve reached the end
                      if (state.users.length % 10 != 0) {
                        hasMoreData = false;
                      } else {
                        skip += limit;
                      }

                      if (state.message != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message!),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is UserListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserListSuccess) {
                      if (state.users.isEmpty) {
                        return const Center(child: Text('No users found.'));
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: state.users.length + (hasMoreData ? 1 : 0),
                        separatorBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Divider(
                                color: context.colorScheme.primary,
                              ),
                            ),
                        itemBuilder: (context, index) {
                          if (index < state.users.length) {
                            final user = state.users[index];
                            return UserTile(user: user);
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
                    } else if (state is UserListByNameSuccess) {
                      final users = state.users;
                      if (users.isEmpty) {
                        return const Center(child: Text('No users found.'));
                      }
                      return ListView.separated(
                        itemCount: users.length,
                        separatorBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Divider(
                                color: context.colorScheme.primary,
                              ),
                            ),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return UserTile(user: user);
                        },
                      );
                    } else if (state is UserListFailure) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
