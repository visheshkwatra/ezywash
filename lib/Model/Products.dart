import 'package:http/http.dart' as http;
import 'dart:convert';

///Model Class for all Products
class Products {
  String name, description;
  int productID, mainID, categoryID;
  double sellingPrice, discountPrice;

  /// isSelected is false for every Category by default
  bool isSelected = false;

  ///contains all categories
  static List<Products> products = [];

  /// contains all selected products
  /// for car category - SUV, it has all SUV car packages
  /// for sanitization - Home, it has all Home sanitization packages
  static List<Products> selectedProducts = [];

  Products(
      {required this.name,
      required this.description,
      required this.productID,
      required this.mainID,
      required this.categoryID,
      required this.sellingPrice,
      required this.discountPrice});

  /// fetching Products data from Products Api
  static Future<void> getProducts() async {
    if (products.length != 0) products.clear();

    try {
      http.Response response = await http
          .get('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/product/' as Uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          products.add(Products(
              name: data[i]["title"],
              description: data[i]["description"],
              productID: data[i]["id"],
              mainID: data[i]["m_cat"],
              categoryID: data[i]["cat"],
              discountPrice: data[i]["discount_price"],
              sellingPrice: data[i]["selling_price"]));
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  /// it is calls when we select any category on Home Page.
  static void fetchSelectedProducts(int selectedCategoryId) {
    if (selectedProducts.length != 0) selectedProducts.clear();

    for (int i = 0; i < products.length; i++) {
      if (products[i].categoryID == selectedCategoryId) {
        if (!selectedProducts.contains(products[i]))
          selectedProducts.add(products[i]);
      }
    }
  }
}
