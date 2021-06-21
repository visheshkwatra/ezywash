///Model Class for Main Categories - Cars , Sanitization  , laundry etc.
class MainCategories {
  String name, imgData;
  int id;

  /// Contains all main categories.
  /// Creating static because it is calling just after opening the app.
  static List<MainCategories> mainCategories = [
    MainCategories(
        name: "Car Wash",
        id: 1,
        imgData:
            "https://i.pinimg.com/originals/d1/2a/6e/d12a6e88e902ffabd87c63791522cfd8.gif"),
    // MainCategories(
    //     name: "Laundry (not in service)",
    //     id: 2,
    //     imgData:
    //         "https://ezywash.in/media/photos/washing_machine-removebg-preview__3_-removebg-preview_W7DqtkR.png"),
    // MainCategories(
    //     name: "Home Cleaning (not in service)",
    //     id: 3,
    //     imgData: "https://ezywash.in/media/photos/aa-removebg-preview.png"),

    MainCategories(name: "Bike Wash", id: 4, imgData: "bike.png"),
    MainCategories(
        name: "Sanitization and Disinfection",
        id: 5,
        imgData: "https://ezywash.in/media/photos/4_XXg86Ll.jpg"),

    MainCategories(name: "HatchBack", id: 6, imgData: "03.png"),
    MainCategories(name: "Sedan", id: 7, imgData: "04.png"),
    MainCategories(name: "SUV", id: 8, imgData: "02.png"),
    MainCategories(name: "MPV", id: 9, imgData: "01.png"),
  ];

  MainCategories({this.name, this.imgData, this.id});
}
