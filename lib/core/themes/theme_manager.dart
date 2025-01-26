import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/theme_mode.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeManager {
  static Future<ThemeData> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int themeCode = preferences.getInt('theme') ?? 0;
    return _ModeMap[Mode.values.elementAt(themeCode)]!;
  }

  static ThemeData getTheme(Mode mode) => _ModeMap[mode]!;

  static Future<void> setTheme(Mode mode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('theme', Mode.values.indexOf(mode));
  }

  static final Map<Mode, ThemeData> _ModeMap = {
    Mode.light: lightTheme,
    Mode.dark: darkTheme,
  };
}
