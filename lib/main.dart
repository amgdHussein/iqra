import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/blocs/blocs.dart';
import 'core/l10n/localization_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the localization
  Locale appLocale = await LanguageManager.loadLocalization();

  // Set the BlocObserver
  Bloc.observer = IqraBlocObserver();

  // Run the app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (BuildContext context) => LocalizationBloc(appLocale),
        ),
      ],
      child: const IqraApp(),
    ),
  );
}
