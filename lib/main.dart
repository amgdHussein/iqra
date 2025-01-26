import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'blocs/blocs.dart';
import 'configs/configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the localization
  Locale appLocale = await LanguageConfig.loadLocalization();

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
