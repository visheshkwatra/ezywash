import 'package:http/http.dart' as http;
import 'dart:convert';

///Model Class for all Categories
class Categories {
  String name;
  int categoryID, mainID;

  /// isSelected is false for every Category by default
  bool isSelected = false;

  ///contains all categories
  static List<Categories> categories = [];

  /// contains all selected categories
  /// for car , it has all car categories
  /// for sanitization , it has all sanitization categories
  static List<Categories> selectedCategories = [];

  Categories({required this.name, required this.mainID, required this.categoryID});

  /// fetching Categories data from Categories Api
  static Future<void> getCategories() async {
    if (categories.length != 0) categories.clear();

    try {
      http.Response response = await http
          .get('https://ezywash.in/22D92D50C1FFE2697C24336CDCDapi/c/' as Uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          categories.add(Categories(
              name: data[i]["name"],
              mainID: data[i]["m_cat"],
              categoryID: data[i]["id"]));
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  /// it is calls while starting home page as it will list with categories of selected Main Categories
  static void fetchSelectedCategories(int selectedMainCategory) {
    if (selectedCategories.length != 0) selectedCategories.clear();

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].mainID == selectedMainCategory) {
        if (!selectedCategories.contains(categories[i]))
          selectedCategories.add(categories[i]);
      }
    }
    print(selectedCategories.length);
  }
}
