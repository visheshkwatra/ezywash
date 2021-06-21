import 'package:carwash/Global%20Theme.dart';
import 'package:carwash/Screen/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carwash/ExtraScreen/extrascreen.dart' show Splash;
import 'package:carwash/ExtraScreen/extrascreen.dart' show TermsAndConditions;

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
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Restrict The App to be used in only Portrait Mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 1500)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          /// Show Splash Screen
          return MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: currentTheme.currentTheme(),
              debugShowCheckedModeBanner: false,
              home: Splash());
        } else {
          return MaterialApp(
            /// DARK Theme
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme(
                  primary: Color.fromRGBO(38, 37, 51, 0.9),
                  primaryVariant: Color.fromRGBO(38, 37, 51, 0.9),
                  secondary: Colors.greenAccent,
                  secondaryVariant: Colors.greenAccent,
                  surface: Color.fromRGBO(68, 66, 80, 1),
                  background: Color.fromRGBO(38, 37, 51, 1),
                  error: Colors.red,
                  onPrimary: Colors.grey[200],
                  onSecondary: Colors.grey[200],
                  onSurface: Colors.grey[200],
                  onBackground: Colors.white,
                  onError: Colors.white,
                  brightness: Brightness.dark),
            ),

            /// Light Theme
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme(
                  primary: Colors.white,
                  primaryVariant: Colors.white,
                  secondary: Colors.blueAccent,
                  secondaryVariant: Colors.blueAccent,
                  surface: Colors.grey[200],
                  background: Colors.white,
                  error: Colors.red,
                  onPrimary: Color.fromRGBO(38, 37, 51, 0.9),
                  onSecondary: Color.fromRGBO(38, 37, 51, 0.9),
                  onSurface: Color.fromRGBO(38, 37, 51, 0.9),
                  onBackground: Color.fromRGBO(38, 37, 51, 0.9),
                  onError: Colors.white,
                  brightness: Brightness.light),
            ),
            themeMode: currentTheme.currentTheme(),
            debugShowCheckedModeBanner: false,

            home: InitialPage(),
            initialRoute: InitialPage.id,
            routes: {
              InitialPage.id: (context) => InitialPage(),
              HomePage.id: (context) => HomePage(),
              ConfirmationPage.id: (context) => ConfirmationPage(),
              BookedPage.id: (context) => BookedPage(),
              WebsiteWebView.id: (context) => WebsiteWebView(),
              UserLogin.id: (context) => UserLogin(),
              UserRegister.id: (context) => UserRegister(),
              TermsAndConditions.id: (context) => TermsAndConditions(),
              AboutUs.id: (context) => AboutUs(),
              CartPage.id: (context) => CartPage(),
              CarCategoriesPage.id: (context) => CarCategoriesPage(),
            },
          );
        }
      },
    );
  }
}

/// CREDENTIAL SHA 1 KEYS FOR RELEASE APP

/// sha1 on google map api  ---> 17:39:E2:1C:B9:F1:9D:6C:48:FD:8B:01:5E:A2:D5:04:97:2F:4E:B5

/// release google map --->  17:39:E2:1C:B9:F1:9D:6C:48:FD:8B:01:5E:A2:D5:04:97:2F:4E:B5

/// release sha1 for app --->  C0:47:4D:D2:03:84:76:BC:80:FA:1D:1D:93:64:09:D1:ED:AF:29:30
