import 'package:carwash/Model/SelectedInformationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///Model Class for all Bookings
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

  Booking(
      {this.productID,
      this.customerAddress,
      this.customerID,
      this.customerPhoneNumber,
      this.customerName,
      this.bookingID,
      this.date,
      this.orderDate,
      this.time});

  ///contains all products in Cart
  static List<Booking> cartProducts = [];

  /// Contain all product for specific Customer
  static List<Booking> userSpecificCartProducts = [];

  /// Storing CART elements
  ///Post product from cart API's
  static Future<void> postProductToCart() async {
    try {
      http.Response response = await http.post(
          'https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/dc/',
          body: {});
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  ///Getting CART element
  ///fetch all products from cart API's
  static Future<void> getProductsForCart() async {
    if (cartProducts.length != 0) cartProducts.clear();

    try {
      http.Response response = await http
          .get('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/dc/');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          cartProducts.add(Booking());
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  /// ORDER PRODUCT
  ///Book Product, send product to orders API's
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
          'https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/order/',
          body: {
            "customer": SelectedInformation.customerID.toString(),
            "product": SelectedInformation.productID.toString(),
            "date": SelectedInformation.date.toString(),
            "time": SelectedInformation.time.toString(),
            "name": SelectedInformation.categoryName.toString(),
            "phone": SelectedInformation.customerPhoneNumber.toString(),
            "address": SelectedInformation.customerAddress.toString(),
            "city": "New Delhi",
            "state": "Delhi",
            "zip": "0",
            "orderdate": "2021-05-12"
          });
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

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
