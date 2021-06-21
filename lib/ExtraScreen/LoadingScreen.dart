import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          height: 120,
          width: 120,
          child: LiquidCircularProgressIndicator(
            value: 0.40,
            backgroundColor: Theme.of(context).colorScheme.background,
            borderColor: Theme.of(context).colorScheme.secondary,
            borderWidth: 1,
            direction: Axis
                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: Text(
              "Loading...",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ),
      ),
    );
  }
}
