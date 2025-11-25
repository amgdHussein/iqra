import 'package:flutter/material.dart';

import '../../../../core/enums/navigation_destination.dart';
import '../../../../core/models/navigation_item.dart';
import '../lookups.dart';
import 'router.dart';

class AppDrawer extends StatelessWidget {
  final NavigationItem navigationItem;
  const AppDrawer({super.key, required this.navigationItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.school_rounded,
                  size: 48,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                const SizedBox(height: 8),
                Text(
                  'IQRA Network',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...[
            Destination.home,
            // Destination.statistics,
            // Destination.notes,
            // Destination.roadmap,
          ].map((dynamic destination) {
            return DrawerListTile(
              navigationItem: lookupNavigationItem(context, destination),
              selected: navigationItem.destination == destination,
              onTap: () {
                if (navigationItem.destination != destination) {
                  AppRouter.replacePage(context, destination);
                }
              },
            );
          }),
          const Divider(),
          DrawerListTile(
            navigationItem: lookupNavigationItem(context, Destination.settings),
            selected: navigationItem.destination == Destination.settings,
            onTap: () {
              if (navigationItem.destination != Destination.settings) {
                AppRouter.replacePage(context, Destination.settings);
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final NavigationItem navigationItem;
  final bool selected;
  final void Function()? onTap;
  const DrawerListTile({
    super.key,
    required this.navigationItem,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Icon(navigationItem.icon),
        title: Text(navigationItem.title),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        selected: selected,
        selectedTileColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      ),
    );
  }
}
