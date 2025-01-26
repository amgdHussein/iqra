import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the generated files
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/blocs/l10n/localization_bloc.dart';
import 'core/pages/l10n_demo.dart';

class IqraApp extends StatelessWidget {
  const IqraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (localizationContext, localizationState) {
        return MaterialApp(
          title: 'IQRA Network',
          debugShowCheckedModeBanner: false,
          locale: localizationState.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: L10NDemoPage(),
        );
      },
    );
  }
}
