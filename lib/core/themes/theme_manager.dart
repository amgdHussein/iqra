import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/theme_mode.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeManager {
  final SharedPreferences preferences;

  ThemeManager(this.preferences);

  ThemeData loadTheme() {
    final int themeCode = preferences.getInt('theme') ?? 0;
    final Mode mode = Mode.values.elementAt(themeCode);
    return _themeMap[mode]!;
  }

  ThemeData getTheme(Mode mode) => _themeMap[mode]!;

  Future<bool> setTheme(Mode mode) async {
    return preferences.setInt('theme', Mode.values.indexOf(mode));
  }

  final Map<Mode, ThemeData> _themeMap = {
    Mode.light: lightTheme,
    Mode.dark: darkTheme,
  };
}
