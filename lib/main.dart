import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import the generated files
import 'configs/firebase_options.dart';

// Core
import 'core/blocs/blocs.dart';
import 'core/l10n/localization_manager.dart';
import 'core/themes/theme_manager.dart';

// Feathers
import 'modules/auth/presentation/bloc/auth_bloc.dart';

import 'app.dart';
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
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => di.getIt<AuthBloc>()..add(ListenAuthentication()),
        ),
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => NavigationBloc(),
        ),
      ],
      child: const IqraApp(),
    ),
  );
}
