import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/blocs.dart';
import '../../../core/enums/enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Theme Settings Section
            Text(
              l10n.settingsThemeTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            _buildThemeCard(context, l10n, theme),
            const SizedBox(height: 24),

            // Language Settings Section
            Text(
              l10n.settingsLanguagesTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            _buildLanguageCard(context, l10n, theme),
            const SizedBox(height: 24),

            // Account Section
            Text(
              'Account',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            _buildAccountCard(context, l10n, theme),
          ],
        );
      },
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isLightTheme = themeState.theme.brightness == Brightness.light;

        return Card(
          child: Column(
            children: [
              _buildThemeOption(
                context,
                l10n,
                theme,
                Mode.light,
                l10n.settingsThemeLightTitle,
                Icons.light_mode,
                isLightTheme,
              ),
              const Divider(height: 1),
              _buildThemeOption(
                context,
                l10n,
                theme,
                Mode.dark,
                l10n.settingsThemeDarkTitle,
                Icons.dark_mode,
                !isLightTheme,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    Mode mode,
    String title,
    IconData icon,
    bool isSelected,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
          : null,
      selected: isSelected,
      onTap: () {
        context.read<ThemeBloc>().add(ThemeChanged(mode: mode));
      },
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, localizationState) {
        final currentLocale = localizationState.locale.languageCode;

        return Card(
          child: Column(
            children: [
              _buildLanguageOption(
                context,
                l10n,
                theme,
                Language.en,
                l10n.settingsLanguagesEnglishTitle,
                Icons.language,
                currentLocale == 'en',
              ),
              const Divider(height: 1),
              _buildLanguageOption(
                context,
                l10n,
                theme,
                Language.ar,
                l10n.settingsLanguagesArabicTitle,
                Icons.language,
                currentLocale == 'ar',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    Language language,
    String title,
    IconData icon,
    bool isSelected,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
          : null,
      selected: isSelected,
      onTap: () {
        context.read<LocalizationBloc>().add(LocalizationChanged(language: language));
      },
    );
  }

  Widget _buildAccountCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.logout, color: theme.colorScheme.error),
            title: Text(
              l10n.homeSignOut,
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () {
              _showSignOutDialog(context, l10n);
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'IQRA Network',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.school_rounded, size: 48),
      children: [
        const Text('A learning platform for Islamic education.'),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.homeSignOut),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(SignOutRequested());
            },
            child: Text(l10n.homeSignOut),
          ),
        ],
      ),
    );
  }
}
