import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    getTheme();
  }
  void changeTheme(ThemeMode themeMode) async {
    emit(ThemeInitial(themeMode: themeMode));
    final sp = await SharedPreferences.getInstance();
    await sp.setString('theme', themeMode.name);
  }

  void getTheme() async {
    final sp = await SharedPreferences.getInstance();
    final themeName = sp.getString('theme') ?? ThemeMode.system.name;
    final themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
    emit(ThemeInitial(themeMode: themeMode));
  }
}
