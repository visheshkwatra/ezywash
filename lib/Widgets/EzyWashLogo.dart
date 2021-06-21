import 'package:carwash/Global%20Theme.dart';
import 'package:flutter/material.dart';

class EzyWashLogo extends StatelessWidget {
  const EzyWashLogo({
    Key key,
    this.size = 80.0,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Image(
          image: currentTheme.currentTheme() == ThemeMode.light
              ? AssetImage('IMAGES/logo black final.png')
              : AssetImage('IMAGES/ez white.png'),
          height: size,
          width: size,
          alignment: FractionalOffset.center),
    );
  }
}
