import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent.shade100),
  snackBarTheme: SnackBarThemeData(),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: const FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.windows: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.linux: const FadeUpwardsPageTransitionsBuilder(),
    },
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black12,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent.shade100),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade900),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey.shade800,
    selectedColor: Colors.deepPurple,
    secondarySelectedColor: Colors.deepPurpleAccent,
    labelStyle: const TextStyle(color: Colors.white),
    secondaryLabelStyle: const TextStyle(color: Colors.white70),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: const FadeForwardsPageTransitionsBuilder(
        backgroundColor: Colors.black,
      ),
      TargetPlatform.iOS: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.windows: const FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.linux: const FadeUpwardsPageTransitionsBuilder(),
    },
  ),
);
