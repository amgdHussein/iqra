import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/theme/theme_bloc.dart';
import '../enums/theme_mode.dart';

class ThemeDemoPage extends StatefulWidget {
  const ThemeDemoPage({super.key});

  @override
  State<ThemeDemoPage> createState() => _ThemeDemoPageState();
}

class _ThemeDemoPageState extends State<ThemeDemoPage> {
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsThemeTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.settingsThemeTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                themeBloc.add(ThemeChanged(mode: Mode.light));
              },
              child: Text(AppLocalizations.of(context)!.settingsThemeLightTitle),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                themeBloc.add(ThemeChanged(mode: Mode.dark));
              },
              child: Text(AppLocalizations.of(context)!.settingsThemeDarkTitle),
            ),
          ],
        ),
      ),
    );
  }
}
