import 'package:breeze/data/datasource/implementations/sqflite_local_datasource_impl.dart';
import 'package:breeze/data/datasource/implementations/user_datasource_impl.dart';
import 'package:breeze/data/datasource/interfaces/local_user_datasource.dart';
import 'package:breeze/data/datasource/interfaces/user_datasource.dart';
import 'package:breeze/data/repository/sqflite_local_user_repository_impl.dart';
import 'package:breeze/data/repository/user_repository_impl.dart';
import 'package:breeze/domain/repository/local_user_repository.dart';
import 'package:breeze/domain/repository/user_repository.dart';
import 'package:breeze/domain/usecases/delete_local_post.dart';
import 'package:breeze/domain/usecases/get_all_users.dart';
import 'package:breeze/domain/usecases/get_local_posts.dart';
import 'package:breeze/domain/usecases/get_user_by_name.dart';
import 'package:breeze/domain/usecases/get_user_posts.dart';
import 'package:breeze/domain/usecases/get_user_todos.dart';
import 'package:breeze/domain/usecases/store_local_post.dart';
import 'package:breeze/presentation/bloc/local_posts/local_posts_bloc.dart';
import 'package:breeze/presentation/bloc/post/post_bloc.dart';
import 'package:breeze/presentation/bloc/todo/todo_bloc.dart';
import 'package:breeze/presentation/bloc/userlist/userlist_bloc.dart';
import 'package:breeze/presentation/cubit/theme/theme_cubit.dart';
import 'package:breeze/utils/http_client/implementations/dio_http_client_impl.dart';
import 'package:breeze/utils/http_client/interface/http_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

Future<void> registerDependencies(GetIt getIt) async {
  getIt.registerLazySingleton<HttpClient>(() => DioHttpClientImpl(Dio()));

  // register datasources
  getIt.registerLazySingleton<UserDataSource>(
    () => UserDatasourceImpl(getIt()),
  );

  // getting db path
  final databasesPath = await getDatabasesPath();
  final path = '$databasesPath/breeze.db';
  final db = await initLocalDatabase(path);
  getIt.registerLazySingleton<LocalUserDataSource>(
    () => SqfliteLocalDatasourceImpl(db),
  );

  // register repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LocalUserRepository>(
    () => SqfliteLocalUserRepositoryImpl(getIt()),
  );

  // register use caes
  getIt.registerFactory(() => GetAllUsers(getIt(), getIt()));
  getIt.registerFactory(() => GetUserPosts(getIt(), getIt()));
  getIt.registerFactory(() => GetUserTodos(getIt(), getIt()));
  getIt.registerFactory(() => GetUserByName(getIt()));
  getIt.registerFactory(() => GetLocalPosts(getIt()));
  getIt.registerFactory(() => StoreLocalPost(getIt()));
  getIt.registerFactory(() => DeleteLocalPost(getIt()));

  // register blocs and cubits
  getIt.registerFactory(() => UserListBloc(getIt(), getIt()));
  getIt.registerFactory(() => PostBloc(getIt()));
  getIt.registerFactory(() => TodoBloc(getIt()));
  getIt.registerFactory(() => ThemeCubit());
  getIt.registerFactory(() => LocalPostsBloc(getIt(), getIt(), getIt()));
}

Future<Database> initLocalDatabase(String path) async {
  final Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users (
          id          TEXT    PRIMARY KEY,
          firstName   TEXT    NOT NULL,
          lastName    TEXT    NOT NULL,
          age         INTEGER NOT NULL,
          gender      TEXT    NOT NULL,
          birthDate   TEXT    NOT NULL,
          image       TEXT    NOT NULL,
          height      REAL    NOT NULL,
          weight      REAL    NOT NULL,
          username    TEXT    NOT NULL,
          email       TEXT    NOT NULL,
          phone       TEXT    NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE posts (
          id          TEXT    PRIMARY KEY,
          userId      TEXT    NOT NULL,
          title       TEXT    NOT NULL,
          body        TEXT    NOT NULL,
          views       INTEGER NOT NULL,
          tags        TEXT    NOT NULL,
          reactions   TEXT    NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE todos (
          id          INTEGER PRIMARY KEY,
          todo        TEXT    NOT NULL,
          completed   INTEGER NOT NULL,
          userId      TEXT    NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE user_posts (
          id          INTEGER PRIMARY KEY AUTOINCREMENT,
          title       TEXT    NOT NULL,
          body        TEXT    NOT NULL
        )
      ''');
    },
  );
  return database;
}
