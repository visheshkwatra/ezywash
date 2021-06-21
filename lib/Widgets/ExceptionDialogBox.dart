import 'package:flutter/material.dart';

Widget exceptionDialog(BuildContext context, dynamic exception) {
  return SimpleDialog(
    backgroundColor: Theme.of(context).colorScheme.background,
    title: Center(
      child: Text(
        'Error',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ),
    children: [
      Text(
        '$exception',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 18,
        ),
      ),
      Text(
        'Try Again!',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 18,
        ),
      ),
    ],
  );
}
