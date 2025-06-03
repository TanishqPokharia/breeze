import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/router/routes.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(AppRoutes.userDetailsRoute, extra: user);
      },
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: context.textTheme.bodyLarge,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.username, style: context.textTheme.bodyMedium),
          Text(user.email, style: context.textTheme.bodyMedium),
        ],
      ),

      isThreeLine: true,
      leading: Hero(
        tag: user.image,
        child: CircleAvatar(backgroundImage: NetworkImage(user.image)),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward_ios, color: context.colorScheme.primary),
        ],
      ),
    );
  }
}
