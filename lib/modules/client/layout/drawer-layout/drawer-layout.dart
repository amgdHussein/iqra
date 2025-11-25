import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqra/modules/client/layout/drawer-layout/drawer.dart';

import '../../../../core/blocs/navigation/navigation_bloc.dart';
import '../../../../core/models/navigation_item.dart';
import '../lookups.dart';

class DrawerLayout extends StatelessWidget {
  const DrawerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final NavigationItem navItem = lookupNavigationItem(context, state.destination);
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            title: Text(navItem.title),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          drawer: AppDrawer(navigationItem: navItem),
          body: lookupScreen(state.destination),
          floatingActionButton: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: lookupFloatingActionButton(state.destination),
          ),
        );
      },
    );
  }
}
