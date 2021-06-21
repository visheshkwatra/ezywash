import 'package:carwash/Widgets/EzyWashLogo.dart';
import 'package:flutter/material.dart';
import 'package:carwash/Global Theme.dart';

/// Splash Screen
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: currentTheme.currentTheme() == ThemeMode.dark
            ? Color.fromRGBO(38, 37, 51, 1)
            : Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EzyWashLogo(
                size: 220,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
