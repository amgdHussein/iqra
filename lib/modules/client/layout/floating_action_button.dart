import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add-problem-tag',
      onPressed: () {
        // AppRouter.pushSlidePage(context, Destination.addProblem, AxisDirection.right);
      },
      child: const Icon(Icons.add),
    );
  }
}
