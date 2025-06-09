import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<Locale> {
  static const String _localeKey = 'locale';
  final SharedPreferences _preferences;

  LocalizationCubit(this._preferences) : super(Locale(_preferences.getString(_localeKey) ?? 'tr'));

  Future<void> changeLocale(String languageCode) async {
    await _preferences.setString(_localeKey, languageCode);
    emit(Locale(languageCode));
  }

  bool get isTurkish => state.languageCode == 'tr';
} 