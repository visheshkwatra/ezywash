import 'package:http/http.dart' as http;
import 'dart:convert';

///Model Class for all Customers
class Customers {
  String email, password, name, phoneNumber;
  int id;

  ///contains all Customers
  static List<Customers> customers = [];

  /// contains all email and password in Map.
  static Map<String, String> uniqueCustomers = {};

  Customers({required this.email, required this.id, required this.password, required this.name, required this.phoneNumber});

  /// fetching all Customers data from Customer Api
  static Future<void> getCustomers() async {
    try {
      http.Response response = await http
          .get('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/customers/' as Uri);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        /// if fetching successful then store all customers in a list
        for (int i = 0; i < data.length; i++) {
          customers.add(Customers(
              email: data[i]['email'],
              password: data[i]['password'],
              id: data[i]['id'],
              name: data[i]['name'],
              phoneNumber: data[i]['phone']));
          uniqueCustomers['${data[i]['email']}'] = data[i]['password'];
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  /// Register The customer with provided credentials
  /// call only after when customer is unique.
  static Future<void> postCustomers(Customers customer) async {
    try {
      http.Response response = await http.post(
          'https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/customers/' as Uri,
          body: {
            "name": customer.name,
            "email": customer.email,
            "phone": customer.phoneNumber,
            "password": customer.password,
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

  /// check weather customer exist or not.
  /// so that we do not get duplicate customers.
  static bool isCustomerUnique(String email) {
    if (uniqueCustomers.containsKey(email)) {
      return false;
    }
    return true;
  }
}
