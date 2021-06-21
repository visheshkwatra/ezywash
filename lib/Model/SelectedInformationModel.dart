class SelectedInformation {
  static String customerName,
      customerEmail,
      customerPhoneNumber,
      mainCategoryName,
      categoryName,
      productName,
      date,
      time,
      customerAddress,
      productDescription;
  static double productPrice;
  static int customerID, mainCategoryID, categoryID, productID;
  // to track the routing information.
  static bool isLoginFromHome;

  static void showData() {
    print("Customer Address:  " + customerAddress);
    print("Customer Name:  " + customerName);
    print("Customer Email:  " + customerEmail);
    print("Customer Phone Number:  " + customerPhoneNumber);
    print("MainCategory Name:  " + mainCategoryName);
    print("Product Name: " + productName);
    print("Category Name: " + categoryName);
    print("Date: " + date);
    print("Time: " + time);
    print("Product Description: " + productDescription);
    print("Product Price: $productPrice");
    print("Customer ID: $customerID");
    print("MainCategory ID: $mainCategoryID");
    print("Category ID: $categoryID");
    print("Product ID: $productID");
  }
}
