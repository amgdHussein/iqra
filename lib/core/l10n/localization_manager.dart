import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/languages.dart';

class LanguageManager {
  final SharedPreferences preferences;

  LanguageManager(this.preferences);

  Locale loadLocalization() {
    final int languageCode = preferences.getInt('language') ?? 0;
    final Language language = Language.values.elementAt(languageCode);
    return _localeMap[language]!;
  }

  Locale getLocalization(Language language) => _localeMap[language]!;

  Future<bool> setLocalization(Language language) async {
    return preferences.setInt('language', Language.values.indexOf(language));
  }

  final Map<Language, Locale> _localeMap = {
    Language.en: Locale('en'),
    Language.ar: Locale('ar'),
  };
}
