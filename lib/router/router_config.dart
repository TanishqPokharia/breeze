import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/presentation/screens/local_posts_screen.dart';
import 'package:breeze/presentation/screens/user_details_screen.dart';
import 'package:breeze/presentation/screens/users_screen.dart';
import 'package:breeze/router/routes.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  final routerConfig = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: AppRoutes.usersRoute,
        path: '/',
        builder: (context, state) {
          return UsersScreen();
        },
        routes: [
          GoRoute(
            name: AppRoutes.userDetailsRoute,
            path: '/details',
            builder: (context, state) {
              final user = state.extra as User;
              return UserDetailsScreen(user: user);
            },
          ),
          GoRoute(
            name: AppRoutes.userPostsRoute,
            path: '/user-posts',
            builder: (context, state) => LocalPostsScreen(),
          ),
        ],
      ),
    ],
  );
}
