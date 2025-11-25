import 'package:flutter/material.dart';

import '../../../core/enums/navigation_destination.dart';
import '../../../core/models/navigation_item.dart';
import '../../../l10n/app_localizations.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import 'floating_action_button.dart';

Widget lookupScreen(Destination destination) {
  switch (destination) {
    case Destination.home:
      return HomeScreen();

    case Destination.settings:
      return SettingsScreen();

    default:
      return HomeScreen();
  }
}

Widget? lookupFloatingActionButton(Destination destination) {
  switch (destination) {
    case Destination.home:
      return const AppFloatingActionButton();

    default:
      return null;
  }
}

NavigationItem lookupNavigationItem(BuildContext context, Destination destination) {
  switch (destination) {
    case Destination.home:
      return NavigationItem(
        title: AppLocalizations.of(context)!.homeTitle,
        destination: Destination.home,
        icon: Icons.home_filled,
      );

    case Destination.settings:
      return NavigationItem(
        destination: Destination.settings,
        title: AppLocalizations.of(context)!.settingsTitle,
        icon: Icons.settings,
      );

    case Destination.theme:
      return NavigationItem(
        destination: Destination.theme,
        title: AppLocalizations.of(context)!.settingsThemeTitle,
        icon: Icons.light_mode_outlined,
      );

    case Destination.languages:
      return NavigationItem(
        destination: Destination.languages,
        title: AppLocalizations.of(context)!.settingsLanguagesTitle,
        icon: Icons.translate,
      );
  }
}
