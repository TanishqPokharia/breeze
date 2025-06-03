import 'package:breeze/presentation/bloc/local_posts/local_posts_bloc.dart';
import 'package:breeze/presentation/bloc/post/post_bloc.dart';
import 'package:breeze/presentation/bloc/todo/todo_bloc.dart';
import 'package:breeze/presentation/bloc/userlist/userlist_bloc.dart';
import 'package:breeze/presentation/cubit/theme/theme_cubit.dart';
import 'package:breeze/router/router_config.dart';
import 'package:breeze/themes/themes.dart';
import 'package:breeze/utils/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies(getIt);
  await getIt.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserListBloc>()),
        BlocProvider(create: (context) => getIt<PostBloc>()),
        BlocProvider(create: (context) => getIt<TodoBloc>()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<LocalPostsBloc>()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Breeze',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                (context.watch<ThemeCubit>().state as ThemeInitial).themeMode,
            // home: const LocalPostsScreen(),
            routerConfig: AppRouter().routerConfig,
          );
        },
      ),
    );
  }
}
