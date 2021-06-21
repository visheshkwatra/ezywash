import 'package:carwash/Model/Model.dart';
import 'package:carwash/Screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:carwash/Widgets/widget.dart';
import 'package:carwash/Screen/HomePage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server
import 'package:loading_overlay/loading_overlay.dart';
import 'package:carwash/Screen/BookedPage.dart';
import 'package:carwash/ExtraScreen/extrascreen.dart';

class ConfirmationPage extends StatefulWidget {
  static String id = "ConfirmationPage";

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool isLoading = false, isTermConditionAccepted = false;
  Future<void> sendMail() async {
    String username = "sales.ezywash@gmail.com";
    String password = "Aman.8802058902";
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(SelectedInformation.customerEmail)
      ..subject = 'EzyWash Booking Confirmation' //subject of the email
      ..text =
          "Hi ${SelectedInformation.customerName}, \nThankYou for selecting ${SelectedInformation.categoryName}, ${SelectedInformation.productName} \n"
              "Your Service Are:- \n"
              "${SelectedInformation.productDescription} \n"
              "Service Price: ₹${SelectedInformation.productPrice} only. \n"
              "We Will Contact You Soon, Contact for further details - 8287689633";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Theme.of(context).colorScheme.secondary,
      isLoading: isLoading,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Card(
                    shadowColor: Theme.of(context).colorScheme.secondary,
                    color: Theme.of(context).colorScheme.background,
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                              child: GradientText(
                                  text: 'Confirm Your Booking',
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.greenAccent,
                                  ]),
                                  size: 24)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Confirmation #',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.75),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '${SelectedInformation.customerID}${SelectedInformation.categoryID}${SelectedInformation.productID}',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                text: 'Appointment Info',
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.greenAccent,
                                ]),
                                size: 22,
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                endIndent: 120,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Service:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.categoryName}, ${SelectedInformation.productName}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Service Description:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.productDescription}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Date:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.date}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Time:',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.75),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.time}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                text: 'Customer Info',
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.greenAccent,
                                ]),
                                size: 22,
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                endIndent: 150,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Name:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.customerName}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Email:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.customerEmail}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Phone:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.customerPhoneNumber}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Address',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${SelectedInformation.customerAddress}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                  text: 'Payment Info',
                                  size: 22,
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.greenAccent,
                                  ])),
                              Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                endIndent: 160,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Payment method:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Pay Locally',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Total Amount Due:',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.75),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                '${SelectedInformation.productPrice}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  fillColor: MaterialStateProperty.all(
                                      isTermConditionAccepted
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Colors.grey),
                                  value: isTermConditionAccepted,
                                  onChanged: (_) {
                                    setState(() {
                                      isTermConditionAccepted =
                                          !isTermConditionAccepted;
                                    });
                                  },
                                ),
                                // Text(
                                //   'Please Read Our Terms And Conditions',
                                //   style: TextStyle(
                                //       color: Theme.of(context)
                                //           .colorScheme
                                //           .onBackground,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w300,
                                //       fontStyle: FontStyle.italic),
                                // ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(TermsAndConditions.id);
                                  },
                                  child: Text('Accept Terms And Conditions',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UnicornOutlineButton(
                                  strokeWidth: 2,
                                  radius: 24,
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.greenAccent,
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 8),
                                    child: GradientText(
                                      text: 'Edit',
                                      gradient: LinearGradient(colors: [
                                        Colors.greenAccent,
                                        Colors.blue,
                                      ]),
                                      size: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomePage.id, (route) => false);
                                  },
                                ),
                                UnicornOutlineButton(
                                    strokeWidth: 2,
                                    radius: 24,
                                    gradient: LinearGradient(colors: [
                                      Colors.blue,
                                      Colors.greenAccent,
                                    ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 8),
                                      child: GradientText(
                                        text: 'Confirm',
                                        gradient: LinearGradient(colors: [
                                          Colors.greenAccent,
                                          Colors.blue,
                                        ]),
                                        size: 18,
                                      ),
                                    ),
                                    onPressed: () {
                                      try {
                                        if (isTermConditionAccepted) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Booking.bookProduct();

                                          sendMail().then((value) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    BookedPage.id);
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            content: Text(
                                              'Please Read And Accept Terms And Conditions.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground),
                                            ),
                                            duration:
                                                Duration(milliseconds: 1200),
                                          ));
                                        }
                                      } catch (exception) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => exceptionDialog(
                                              context, exception),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
