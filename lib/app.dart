import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the generated files
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/blocs/blocs.dart';
import 'core/pages/pages.dart';
import 'modules/auth/auth.dart';

class IqraApp extends StatelessWidget {
  const IqraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (localizationContext, localizationState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (themeContext, themeState) {
            return MaterialApp(
              title: 'IQRA Network',
              debugShowCheckedModeBanner: false,
              locale: localizationState.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => locale,
              theme: themeState.theme,
              home: BlocBuilder<InternetConnectionBloc, InternetConnectionState>(
                builder: (connectionContext, connectionState) {
                  if (connectionState.isConnected == false) {
                    return const InternetConnectionPage();
                  }

                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (authContext, authState) {
                      if (authState.status != AuthStatus.authenticated) {
                        return SignInPage();
                      }

                      return AuthDemoPage();
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
