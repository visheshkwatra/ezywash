import 'package:carwash/ExtraScreen/LoadingScreen.dart';
import 'package:carwash/Widgets/widget.dart';
import 'package:carwash/Screen/InitialPage.dart';
import 'package:carwash/FormScreen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:carwash/Model/Model.dart';

class CartPage extends StatefulWidget {
  static String id = "CartPage";

  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Booking.getProductsForCart().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingScreen();
    } else {
      if (SelectedInformation.customerName == null) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Booking History'),
            ),
            body: Container(
              child: Center(
                child: UnicornOutlineButton(
                  strokeWidth: 2,
                  radius: 24,
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.greenAccent,
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 18),
                    child: GradientText(
                      text: 'Login First',
                      gradient: LinearGradient(colors: [
                        Colors.greenAccent,
                        Colors.blue,
                      ]),
                      size: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(UserLogin.id);
                  },
                ),
              ),
            ),
          ),
        );
      }
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Booking History'),
            ),
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No Bookings',
                      style: TextStyle(color: Colors.white),
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
                            horizontal: 32, vertical: 12),
                        child: GradientText(
                          text: 'Book Your Wash',
                          gradient: LinearGradient(colors: [
                            Colors.greenAccent,
                            Colors.blue,
                          ]),
                          size: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(InitialPage.id);
                      },
                    ),
                  ],
                ),
              ),
            )),
      );
    }
  }
}
