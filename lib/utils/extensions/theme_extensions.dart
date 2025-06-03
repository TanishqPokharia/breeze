import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => colorScheme.primary;

  Color get secondaryColor => colorScheme.secondary;

  Color get surfaceColor => colorScheme.surface;

  Color get errorColor => colorScheme.error;
}
