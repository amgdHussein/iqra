import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/animations/animations.dart';
import '../../../core/blocs/navigation/navigation_bloc.dart';
import '../../../core/enums/navigation_destination.dart';
import 'lookups.dart';

class AppRouter {
  static void replacePage(BuildContext context, Destination destination) {
    Navigator.pop(context);
    context.read<NavigationBloc>().add(DestinationChanged(destination: destination));
  }

  static Future<dynamic> pushPage(BuildContext context, Destination destination) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => lookupScreen(destination)),
    );
  }

  static Future<dynamic> pushBouncyPage(BuildContext context, Destination destination) {
    return Navigator.push(
      context,
      BouncyPageRoute(screen: lookupScreen(destination)),
    );
  }

  static Future<dynamic> pushSlidePage(BuildContext context, Destination destination, AxisDirection direction) {
    return Navigator.push(
      context,
      SlidePageRoute(
        screen: lookupScreen(destination),
        direction: direction,
      ),
    );
  }

  static Future<dynamic> pushFadePage(BuildContext context, Destination destination) {
    return Navigator.push(
      context,
      FadePageRoute(screen: lookupScreen(destination)),
    );
  }

  static Future<dynamic> pushEnterExitPage(
    BuildContext context, {
    required Destination source,
    required Destination destination,
    required AxisDirection direction,
  }) {
    return Navigator.push(
      context,
      EnterExitPageRoute(
        enterPage: lookupScreen(source),
        exitPage: lookupScreen(destination),
        direction: direction,
      ),
    );
  }

  static Future<dynamic> pushDialog(BuildContext context, Destination destination) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => lookupScreen(destination),
    );
  }
}
