import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../blocs/l10n/localization_bloc.dart';
import '../enums/languages.dart';

class L10NDemoPage extends StatefulWidget {
  const L10NDemoPage({super.key});

  @override
  State<L10NDemoPage> createState() => _L10NDemoPageState();
}

class _L10NDemoPageState extends State<L10NDemoPage> {
  @override
  Widget build(BuildContext context) {
    final localizationBloc = BlocProvider.of<LocalizationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.settingsLanguagesTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                localizationBloc.add(
                  LocalizationChanged(language: Language.en),
                );
              },
              child: Text(AppLocalizations.of(context)!.settingsLanguagesEnglishTitle),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                localizationBloc.add(
                  LocalizationChanged(language: Language.ar),
                );
              },
              child: Text(AppLocalizations.of(context)!.settingsLanguagesArabicTitle),
            ),
          ],
        ),
      ),
    );
  }
}
