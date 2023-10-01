import 'package:carwash/Model/Model.dart';
import 'package:carwash/Model/SelectedInformationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Booking {
  int bookingID;
  int customerID;
  int productID;
  String date;
  String time;
  String customerName;
  String customerPhoneNumber;
  String customerAddress;
  String orderDate;

  Booking({
    required this.productID,
    required this.customerAddress,
    required this.customerID,
    required this.customerPhoneNumber,
    required this.customerName,
    required this.bookingID,
    required this.date,
    required this.orderDate,
    required this.time,
  }) {
    // Default values are provided, no need to assign null here.
  }

  // Contains all products in Cart
  static List<Booking> cartProducts = [];

  // Contains all products for a specific Customer
  static List<Booking> userSpecificCartProducts = [];

  // Post product to cart API
  static Future<void> postProductToCart() async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/dc/'),
        body: {},
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // Get products from cart API
  static Future<void> getProductsForCart() async {
    if (cartProducts.isNotEmpty) cartProducts.clear();

    try {
      http.Response response = await http.get(
        Uri.parse('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/dc/'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          cartProducts.add(Booking(
            productID: 0,  // Replace with actual value
            customerPhoneNumber: '',
            customerAddress: '',
            customerID: 0,  // Replace with actual value
            customerName: '',
            orderDate: '',
            bookingID: 0,  // Replace with actual value
            date: '',
            time: '',
          ));
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // Book Product and send to orders API
  static Future<void> bookProduct() async {
    print(SelectedInformation.customerID);
    print(SelectedInformation.productID);
    print(SelectedInformation.date);
    print(SelectedInformation.time);
    print(SelectedInformation.categoryName);
    print(SelectedInformation.customerPhoneNumber);
    print(SelectedInformation.customerAddress);

    try {
      http.Response response = await http.post(
        Uri.parse('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/order/'),
        body: {
          "customer": SelectedInformation.customerID.toString(),
          "product": SelectedInformation.productID.toString(),
          "date": SelectedInformation.date.toString(),
          "time": "12:00 PM",
          "name": SelectedInformation.categoryName.toString(),
          "phone": SelectedInformation.customerPhoneNumber.toString(),
          "address": SelectedInformation.customerAddress.toString(),
          "city": "New Delhi",
          "state": "Delhi",
          "zip": "0",
          "orderdate": "2021-05-12"
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // Get user-specific cart products
  static void getUserSpecificCartProduct() {
    for (int i = 0; i < cartProducts.length; i++) {
      if (SelectedInformation.customerID == cartProducts[i].customerID) {
        userSpecificCartProducts.add(cartProducts[i]);
      }
    }
  }
}

/*


 {
        "id": 1,
        "customer": 3,
        "product": 65,
        "date": "2021-11-11",
        "time": "00:12:00",
        "name": "danny",
        "phone": "232432",
        "address": "432",
        "city": "423",
        "state": "ewfw",
        "zip": "3243243",
        "orderdate": "2021-05-09"
    },
 */
