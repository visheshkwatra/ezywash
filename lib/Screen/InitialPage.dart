import 'package:carwash/Model/Model.dart';
import 'package:carwash/Screen/HomePage.dart';
import 'package:carwash/Widgets/EzyWashLogo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:carwash/Screen/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// It will be the first page when app Opens
class InitialPage extends StatefulWidget {
  static String id = "InitialPage";
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool hasNetwork = true; // to check whether the device has internet access or not
  late int userID;

  /// Check whether the device has Internet access or not


  Future<String> checkNetwork(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return "No Network";
    } else {
      return "Connected to the network";
    }
  }
  /// Getting user data from session

  /// To ensure the app will not close on pressing the back button
  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(
          child: Text(
            'Are you sure?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        content: Text(
          'Do you want to exit an App',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(10),
              backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.background),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(10),
              backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.background),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Yes',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    ) ?? false;
  }

  getCurrentUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getInt('UserId')!;
    if (userID != null) {
      SelectedInformation.customerID = userID;
      SelectedInformation.customerPhoneNumber = pref.getString("phone")!;
      SelectedInformation.customerName = pref.getString('name')!;
      SelectedInformation.customerEmail = pref.getString('email')!;
      SelectedInformation.customerPhoneNumber = pref.getString('phoneNumber')!;
    }
  }

  @override
  void initState() {
    super.initState();
    checkNetwork(context).then((value) {
      if (value == "No Network")
        setState(() {
          hasNetwork = false;
        });
      else
        setState(() {
          hasNetwork = true;
        });
    });
    getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    /// If the device does not have network access then redirect to NoInternetPage
    if (hasNetwork == false) {
      /// The App will show the message - No Internet
      /// And close the app after 5 seconds
      return NoInternetBuilderScreen();
    } else {
      /// If the device has network access then show MainPage
      /// It shows the loading screen while fetching the MainCategories, Categories, and Products from External APIs
      return SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        EzyWashLogo(),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(CarCategoriesPage.id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    image: DecorationImage(
                                        image: AssetImage('IMAGES/carfinal2.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  '${MainCategories.mainCategories[0].name ?? ''}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            SelectedInformation.mainCategoryID =
                                MainCategories.mainCategories[1].id ?? 6;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    image: DecorationImage(
                                        image: AssetImage('IMAGES/bike.png'),
                                        fit: BoxFit.contain)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  '${MainCategories.mainCategories[1].name ?? ''}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            SelectedInformation.mainCategoryID =
                                MainCategories.mainCategories[2].id ?? 5;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 5,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    image: DecorationImage(
                                        image: AssetImage('IMAGES/sanitizer remove bg.png'),
                                        fit: BoxFit.contain)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  '${MainCategories.mainCategories[2].name ?? ''}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
