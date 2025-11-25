import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final user = firebase.FirebaseAuth.instance.currentUser;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeCard(context, l10n, theme, user),
              const SizedBox(height: 24),

              // Quick Actions Section
              Text(
                l10n.homeQuickActions,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(context, l10n, theme),
              const SizedBox(height: 24),

              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showSignOutDialog(context, l10n);
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(l10n.homeSignOut),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    foregroundColor: theme.colorScheme.error,
                    side: BorderSide(color: theme.colorScheme.error),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    firebase.User? user,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    _getInitials(user?.displayName ?? user?.email ?? ''),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeWelcome,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.displayName ?? user?.email ?? l10n.homeGreeting,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (user?.email != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      user!.email!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final quickActions = [
      _QuickAction(
        icon: Icons.bar_chart_rounded,
        title: l10n.homeStatistics,
        description: l10n.homeStatisticsDesc,
        color: Colors.blue,
        onTap: () {
          // TODO: Navigate to statistics
          _showComingSoonSnackbar(context);
        },
      ),
      _QuickAction(
        icon: Icons.note_alt_outlined,
        title: l10n.homeNotes,
        description: l10n.homeNotesDesc,
        color: Colors.green,
        onTap: () {
          // TODO: Navigate to notes
          _showComingSoonSnackbar(context);
        },
      ),
      _QuickAction(
        icon: Icons.map_outlined,
        title: l10n.homeRoadmap,
        description: l10n.homeRoadmapDesc,
        color: Colors.orange,
        onTap: () {
          // TODO: Navigate to roadmap
          _showComingSoonSnackbar(context);
        },
      ),
      _QuickAction(
        icon: Icons.person_outline,
        title: l10n.homeProfile,
        description: l10n.homeProfileDesc,
        color: Colors.purple,
        onTap: () {
          // TODO: Navigate to profile
          _showComingSoonSnackbar(context);
        },
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return _buildActionCard(context, theme, action);
      },
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    ThemeData theme,
    _QuickAction action,
  ) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: action.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  action.icon,
                  size: 32,
                  color: action.color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                action.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                action.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  void _showSignOutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.homeSignOut),
        content: Text('Are you sure you want to sign out?'),
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

  void _showComingSoonSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  _QuickAction({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });
}
