import 'package:breeze/domain/entities/user.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          spacing: 10,
          children: [
            Column(
              children: [
                Text("Height", style: context.textTheme.titleMedium),
                Text("${user.height} cm", style: context.textTheme.bodyLarge),
              ],
            ),
            Column(
              children: [
                Text("Age", style: context.textTheme.titleMedium),
                Text("${user.age} years", style: context.textTheme.bodyLarge),
              ],
            ),
            Column(
              children: [
                Text("Gender", style: context.textTheme.titleMedium),
                Text(user.gender, style: context.textTheme.bodyLarge),
              ],
            ),
          ],
        ),
        Column(
          spacing: 10,
          children: [
            Column(
              children: [
                Text("Weight", style: context.textTheme.titleMedium),
                Text("${user.weight} kg", style: context.textTheme.bodyLarge),
              ],
            ),
            Column(
              children: [
                Text("Birth Date", style: context.textTheme.titleMedium),
                Text(user.birthDate, style: context.textTheme.bodyLarge),
              ],
            ),
            Column(
              children: [
                Text("Phone", style: context.textTheme.titleMedium),
                Text(user.phone, style: context.textTheme.bodyLarge),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
