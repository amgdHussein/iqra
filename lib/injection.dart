import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/localization_manager.dart';
import 'core/themes/theme_manager.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // * External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // * Core
  getIt.registerLazySingleton<LanguageManager>(() => LanguageManager(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<ThemeManager>(() => ThemeManager(getIt<SharedPreferences>()));
}
