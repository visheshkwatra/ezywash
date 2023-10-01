import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoInternetBuilderScreen extends StatelessWidget {
  const NoInternetBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return NoInternetPage();
            case ConnectionState.done:
              SystemNavigator.pop(); // Close the app
              break;
            default:
              break;
          }
          return NoInternetPage(); // Return NoInternetPage in all other cases
        },
      ),
    );
  }
}

/// No Internet page - just like a 400 Error Page
class NoInternetPage extends StatelessWidget {
  const NoInternetPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('IMAGES/no-wifi.png'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No Internet',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please Connect To Internet ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Closing App ... ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
