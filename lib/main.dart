import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'configs/firebase_options.dart';
import 'core/blocs/blocs.dart';
import 'core/l10n/localization_manager.dart';
import 'core/themes/theme_manager.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.initializeDependencies();

  // Set the BlocObserver
  Bloc.observer = IqraBlocObserver();

  // Run the app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (BuildContext context) => LocalizationBloc(di.getIt<LanguageManager>()),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(di.getIt<ThemeManager>()),
        ),
        BlocProvider<InternetConnectionBloc>(
          create: (BuildContext context) => InternetConnectionBloc()..add(ListenConnection()),
        ),
      ],
      child: const IqraApp(),
    ),
  );
}
