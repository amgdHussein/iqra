import 'package:flutter/material.dart';

import '../../../core/enums/navigation_destination.dart';
import '../../../core/models/navigation_item.dart';
import '../../../l10n/app_localizations.dart';
import '../screens/home_screen.dart';
import '../screens/homework_screen.dart';
import '../screens/lessons_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/settings_screen.dart';
import 'floating_action_button.dart';

Widget lookupScreen(Destination destination) {
  switch (destination) {
    case Destination.home:
      return const HomeScreen();

    case Destination.settings:
      return const SettingsScreen();

    case Destination.lessons:
      return const LessonsScreen();

    case Destination.homework:
      return const HomeworkScreen();

    case Destination.progress:
      return const ProgressScreen();

    case Destination.menu:
      return const SettingsScreen();

    default:
      return const HomeScreen();
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
  final l10n = AppLocalizations.of(context)!;

  switch (destination) {
    case Destination.home:
      return NavigationItem(
        title: l10n.homeTitle,
        destination: Destination.home,
        icon: Icons.home_filled,
      );

    case Destination.settings:
      return NavigationItem(
        destination: Destination.settings,
        title: l10n.settingsTitle,
        icon: Icons.settings,
      );

    case Destination.theme:
      return NavigationItem(
        destination: Destination.theme,
        title: l10n.settingsThemeTitle,
        icon: Icons.light_mode_outlined,
      );

    case Destination.languages:
      return NavigationItem(
        destination: Destination.languages,
        title: l10n.settingsLanguagesTitle,
        icon: Icons.translate,
      );

    case Destination.lessons:
      return NavigationItem(
        destination: Destination.lessons,
        title: l10n.lessonsTitle,
        icon: Icons.school,
      );

    case Destination.homework:
      return NavigationItem(
        destination: Destination.homework,
        title: l10n.homeworkTitle,
        icon: Icons.assignment,
      );

    case Destination.progress:
      return NavigationItem(
        destination: Destination.progress,
        title: l10n.progressTitle,
        icon: Icons.analytics,
      );

    case Destination.menu:
      return NavigationItem(
        destination: Destination.menu,
        title: l10n.menuTitle,
        icon: Icons.menu,
      );
  }
}
