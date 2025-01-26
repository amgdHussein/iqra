import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/blocs/blocs.dart';
import 'core/l10n/localization_manager.dart';
import 'core/themes/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the initial localization
  Locale appLocale = await LanguageManager.loadLocalization();

  // Load the initial theme
  ThemeData appTheme = await ThemeManager.loadTheme();

  // Set the BlocObserver
  Bloc.observer = IqraBlocObserver();

  // Run the app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (BuildContext context) => LocalizationBloc(appLocale),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(appTheme),
        ),
        BlocProvider<InternetConnectionBloc>(
          create: (BuildContext context) => InternetConnectionBloc()..add(ListenConnection()),
        ),
      ],
      child: const IqraApp(),
    ),
  );
}
