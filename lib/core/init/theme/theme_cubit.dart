import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this.prefs) : super(_loadTheme(prefs));

  static ThemeMode _loadTheme(SharedPreferences prefs) {
    final isLight = prefs.getBool(_themeKey) ?? false; // Default olarak dark theme
    return isLight ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool(_themeKey, newTheme == ThemeMode.light);
    emit(newTheme);
  }
} 