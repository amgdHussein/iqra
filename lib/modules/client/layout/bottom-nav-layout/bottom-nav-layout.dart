import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/blocs/navigation/navigation_bloc.dart';
import '../../../../core/enums/navigation_destination.dart';
import '../lookups.dart';

class BottomNavLayout extends StatelessWidget {
  const BottomNavLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final currentDestination = _mapToDestination(state.destination);

        return Scaffold(
          appBar: _buildAppBar(context),
          body: lookupScreen(currentDestination),
          bottomNavigationBar: _buildBottomNavigationBar(
            context,
            currentDestination,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Abdelraheem Ahmed',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade700, size: 20),
          ],
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.people_outline, color: Colors.black87),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: _buildNotificationBadge('1'),
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.mail_outline, color: Colors.black87),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: _buildNotificationBadge('1'),
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: _buildNotificationBadge('1'),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildNotificationBadge(String count) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 18,
      ),
      child: Center(
        child: Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Destination _mapToDestination(Destination destination) {
    if (_isAppDestination(destination)) {
      return destination;
    }
    return Destination.lessons;
  }

  bool _isAppDestination(Destination destination) {
    return destination == Destination.lessons ||
        destination == Destination.homework ||
        destination == Destination.progress ||
        destination == Destination.menu;
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    Destination currentDestination,
  ) {
    final destinations = [
      Destination.lessons,
      Destination.homework,
      Destination.progress,
      Destination.menu,
    ];

    final currentIndex = destinations.indexOf(currentDestination);

    return NavigationBar(
      selectedIndex: currentIndex >= 0 ? currentIndex : 0,
      onDestinationSelected: (index) {
        context.read<NavigationBloc>().add(
              DestinationChanged(destination: destinations[index]),
            );
      },
      backgroundColor: Colors.white,
      elevation: 8,
      height: 70,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: destinations.map((destination) {
        final navItem = lookupNavigationItem(context, destination);
        final isSelected = destination == currentDestination;

        return NavigationDestination(
          icon: Icon(
            navItem.icon,
            color: isSelected ? Colors.blue : Colors.grey.shade600,
          ),
          label: navItem.title,
        );
      }).toList(),
    );
  }
}
