import 'package:flutter/material.dart';

import '../enums/navigation_destination.dart';

class NavigationItem {
  final Destination destination;
  final String title;
  final IconData? icon;

  const NavigationItem({
    required this.title,
    required this.destination,
    this.icon,
  });
}
