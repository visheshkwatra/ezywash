import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carwash/ExtraScreen/extrascreen.dart' show Splash, TermsAndConditions;
import 'package:carwash/Screen/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Restrict the app to be used in only Portrait Mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 1500)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show Splash Screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash(),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: InitialPage(),
            initialRoute: InitialPage.id,
            routes: {
              // Define your routes here
            },
          );
        }
      },
    );
  }
}
