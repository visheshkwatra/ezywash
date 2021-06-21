import 'package:carwash/Model/Model.dart';
import 'package:carwash/Screen/InitialPage.dart';
import 'package:flutter/material.dart';

class BookedPage extends StatefulWidget {
  static String id = "BookedPage";
  @override
  _BookedPageState createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Center(
              child: Text(
            'Booking Confirm',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          )),
          elevation: 24,
          shadowColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Image.network(
                            'https://i.pinimg.com/originals/11/61/68/116168e03237e30bbb83ca4b0c59e132.gif'),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Center(
                      child: Text(
                        'Booking Confirmed!',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      'Hey ${SelectedInformation.customerName}, sit back & relax. Your Booking for ${SelectedInformation.categoryName}, ${SelectedInformation.productName} has been Confirmed. \nHave A Great Day!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      'We Will Contact You Soon, Please check email for Confirmation letter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18),
                    ),
                    Spacer(
                      flex: 15,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.greenAccent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0.0, 1.5),
                        blurRadius: 1.5,
                      ),
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(InitialPage.id);
                      },
                      child: Center(
                        child: Text(
                          "Make A New Request",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
