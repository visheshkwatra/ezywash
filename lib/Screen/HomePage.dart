import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:carwash/ExtraScreen/extrascreen.dart' show TermsAndConditions;
import 'package:carwash/Model/Model.dart';
import 'package:carwash/Screen/screens.dart';
import 'package:carwash/Widgets/widget.dart';

import '../Global Theme.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  late int userID;
  late String address;
  bool isDark = false;
  bool isLoading = true;
  ///for Categories
  bool isCarSelected = false;
  bool isLaundrySelected = false;
  bool isHomeCleaningSelected = false;
  bool isPestControlSelected = false;
  bool isSanitizationSelected = false;
  bool isBikeSelected = false;
  bool isCARHatchbackSelected = false;
  bool isCARSedanSelected = false;
  bool isCARSuvSelected = false;
  bool isCARMpvSelected = false;

  /// for DateTime
  bool isDateTimeSelected = false;

  ///  for Car
  bool isCarCategorySelected = false, isCarPackagesSelected = false;

  ///  for Car Categories
  bool isCarHatchbackCategorySelected = false,
      isCarHatchbackPackagesSelected = false;
  bool isCarSedanCategorySelected = false, isCarSedanPackagesSelected = false;
  bool isCarSuvCategorySelected = false, isCarSuvPackagesSelected = false;
  bool isCarMpvCategorySelected = false, isCarMpvPackagesSelected = false;

  /// for Laundry
  bool isLaundryCategorySelected = false;

  /// for Home Cleaning
  bool isHomeCleaningCategorySelected = false,
      isHomeCleaningPackagesSelected = false;

  /// for Pest Control
  bool isPestControlCategorySelected = false,
      isPestControlPackagesSelected = false;

  /// for Sanitization
  bool isSanitizationCategorySelected = false;
  bool isSanitizationPackageSelected = false;

  /// for Sanitization
  bool isBikeCategorySelected = false;
  bool isBikePackageSelected = false;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late TextEditingController addressController;

  ///  Drawers
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget sliderItem(String title, IconData icons, Function action) => ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      leading: Icon(
        icons,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onTap: action());

  /// Date And Time
  late String _hour, _minute, _time;
  DateTime selectedDate = DateTime.now();
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;
  late TimeOfDay selectedTime;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: currentTheme.currentTheme() == ThemeMode.light
              ? ThemeData.light()
              : ThemeData.dark(),
          child: child ?? Container(), // Ensure child is not null
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }


  Future<Null> _selectTime(BuildContext context) async {
    selectedTime = TimeOfDay(hour: hour, minute: minute);


    /// Getting Position of User
    Position position = 0 as Position;
    double latitude, longitude;
    String _currentAddress;
    void _getAddressFromLatLng() async {
      try {
        List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

        Placemark place1 = placemarks[0];
        Placemark place2 = placemarks[1];

        setState(() {
          _currentAddress =
          "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
          print("$_currentAddress");
          addressController = TextEditingController(text: _currentAddress);
          address = _currentAddress;
        });
      } catch (e) {
        print(e);
      }
    }

    void getCurrentLocation() async {
      // Check location access permission
      var status = await Permission.locationWhenInUse.request();
      print(status);

      if (status.isGranted) {
        // If location access is granted, fetch the customer location
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);

        // Declare _markers and _center variables if they are not already declared
        Set<Marker> _markers = {};
        LatLng _center;

        _markers.add(Marker(
            markerId: MarkerId(
                LatLng(position.latitude, position.longitude).toString()),
            position: LatLng(position.latitude, position.longitude)));

        latitude = position.latitude;
        longitude = position.longitude;
        _center = LatLng(latitude, longitude);
        _getAddressFromLatLng();
      } else if (status.isPermanentlyDenied) {
        // If location access is permanently denied, provide static latitude and longitude
        LatLng _center = LatLng(28.6139, 77.2090);
      } else {
        /// if Location Access is denied,
        /// we show an alert box to allow location access for better performance.
        /// it will ask for location permission again.
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .background,
                  title: Center(
                    child: Text(
                      'Allow Access For Location',
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  content: Text(
                    'Allow the location permission for this app for better performance',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onBackground,
                      fontSize: 18,
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor: MaterialStateProperty.all(
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .background)),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        getCurrentLocation();
                      },
                      child: Text(
                        'Allow',
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary),
                      ),
                    ),
                  ],
                ));
      }
    }



  /// Getting address from longitude and latitude to String form.


    /// Google Maps
    Completer<GoogleMapController> _controller = Completer();

    LatLng _center = LatLng(28.6139, 77.2090);
    LatLng _lastMapPosition = _center;

    final Set<Marker> _markers = {};

    MapType _currentMapType = MapType.hybrid;

    void _onCameraMove(CameraPosition position) {
      _lastMapPosition = position.target;
    }

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    Future<void> getData() async {
      await Categories.getCategories();
      await Products.getProducts();
    }

    /// Constructor
    @override
    void initState() {
      super.initState();
      getCurrentLocation(); // for UserLocation

      /// THIS IS THE CODE THAT CAUSING THE ISSUE DURING DEPLOYMENT
      /// ERROR: google map not working when we move app to pause state.
      /// FROM: StackOverflow:
      /// RESOLVED: by following code.
      /// now google map shows even when app come to running state again.
      // SystemChannels.lifecycle.setMessageHandler((msg) {
      //   debugPrint('SystemChannels> $msg');
      //   if (msg == AppLifecycleState.resumed.toString())
      //     setState(() async {
      //       GoogleMapController controller = await _controller.future;
      //       controller.setMapStyle("[]");
      //     });

      //   return null;
      // });

      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

      selectedTime = TimeOfDay(hour: hour, minute: minute);
      _dateController.text = DateFormat.yMd().format(DateTime.now());
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, DateTime
              .now()
              .hour, DateTime
              .now()
              .minute),
          [hh, ':', nn, " ", am]).toString();

      switch (SelectedInformation.mainCategoryID) {
        case 1:
          isCarSelected = true;
          break;
        case 2:
          isLaundrySelected = true;
          break;
        case 3:
          isHomeCleaningSelected = true;
          break;
        case 4:
          isBikeSelected = true;
          break;
        case 5:
          isSanitizationSelected = true;
          break;
        case 6:
          isCARHatchbackSelected = true;
          break;

        case 7:
          isCARSedanSelected = true;
          break;

        case 8:
          isCARSuvSelected = true;
          break;

        case 9:
          isCARMpvSelected = true;
          break;
        default:
      }

      getData().then((value) {
        Categories.fetchSelectedCategories(SelectedInformation.mainCategoryID);
        Products.fetchSelectedProducts(
            Categories.selectedCategories[0].categoryID);
        setState(() {
          isLoading = false;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      if (isLoading) {
        return LoadingScreen();
      }
      return SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            key: _scaffoldKey,

            /// For Drawer
            drawer: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(125),
                    bottomRight: Radius.circular(125)),
                color: Theme
                    .of(context)
                    .colorScheme
                    .background,
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.65,
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  SelectedInformation.customerID != null
                      ? Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .surface,
                            blurRadius: 25.0,
                          ),
                          BoxShadow(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                            blurRadius: 15.0,
                          ),
                        ]),
                    child: Center(
                      child: Text(
                        '${SelectedInformation.customerName[0].toUpperCase()}',
                        // for First Alphabet in Profile Pic
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .background),
                      ),
                    ),
                  )
                      : Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onSurface,
                            blurRadius: 25.0,
                          ),
                          BoxShadow(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                            blurRadius: 15.0,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://blog.tubikstudio.com/wp-content/uploads/2019/01/logo_animation_tubik_design.gif'),
                        )),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SelectedInformation.customerID != null
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          '${SelectedInformation.customerName.toUpperCase()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        Text(
                          '${SelectedInformation.customerEmail}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.75),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: UnicornOutlineButton(
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
                          text: 'LOGIN FIRST',
                          gradient: LinearGradient(colors: [
                            Colors.greenAccent,
                            Colors.blue,
                          ]),
                          size: 18,
                        ),
                      ),
                      onPressed: () {
                        SelectedInformation.isLoginFromHome = true;
                        Navigator.of(context).pushNamed(UserLogin.id);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  sliderItem('Home', Icons.home_outlined, () {
                    Navigator.of(context).pushNamed(InitialPage.id);
                  }),
                  sliderItem('Cart', Icons.add_shopping_cart_outlined, () {
                    Navigator.of(context)
                        .pushNamed(CartPage.id); // will cart  later on
                  }),
                  sliderItem('Change Theme', Icons.settings_outlined, () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            backgroundColor:
                            Theme
                                .of(context)
                                .colorScheme
                                .background,
                            title: Text(
                              'Change App Theme',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            children: [
                              SwitchListTile(
                                value: isDark,
                                onChanged: (value) {
                                  if (this.mounted) {
                                    setState(() {
                                      isDark = !isDark;
                                      currentTheme.switchTheme();
                                      Navigator.of(context).pop();
                                    });
                                  }
                                },
                                title: Text(
                                  'Dark Theme',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onSurface),
                                ),
                              ),
                              SwitchListTile(
                                value: !isDark,
                                onChanged: (value) {
                                  if (this.mounted) {
                                    setState(() {
                                      isDark = !isDark;
                                      currentTheme.switchTheme();
                                      Navigator.of(context).pop();
                                    });
                                  }
                                },
                                title: Text(
                                  'light Theme',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onSurface),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
                  sliderItem('Visit Our Website', Icons.web, () {
                    Navigator.of(context).pushNamed(WebsiteWebView.id);
                  }),
                  sliderItem(
                      'Term & Conditions', Icons.pending_actions_outlined,
                          () {
                        Navigator.of(context).pushNamed(TermsAndConditions.id);
                      }),
                  sliderItem('About Us', Icons.people_alt_outlined, () {
                    Navigator.of(context).pushNamed(AboutUs.id);
                  }),
                  sliderItem('LogOut', Icons.power_settings_new_rounded, () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            backgroundColor: Theme
                                .of(context)
                                .colorScheme
                                .background,
                            title: Center(
                              child: Text(
                                'Do You Really Want To Log Out?',
                                style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            content: Text(
                              'Do you want to exit an App',
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onBackground,
                                fontSize: 18,
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .background)),
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .background)),
                                onPressed: () async {
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  pref.clear();
                                  SelectedInformation.customerPhoneNumber;
                                  SelectedInformation.customerEmail;
                                  SelectedInformation.customerName;
                                  SelectedInformation.customerID;
                                  SelectedInformation.customerAddress;

                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            ],
                          ),
                    );
                  })
                ],
              ),
            ),
            body: Container(
              child: Stack(
                children: [

                  /// For Google Maps
                  _center != null
                      ? GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    mapType: _currentMapType,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                  )
                      : Center(child: CircularProgressIndicator()),

                  /// FOR DRAWER BUTTON
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    //child: DrawerButton(scaffoldKey: _scaffoldKey),
                  ),

                  /// FOR CAR HATCHBACK MAIN PAGE
                  isCARHatchbackSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.car_repair_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarHatchbackCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarHatchbackPackagesSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Packages',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// FOR CAR SEDAN MAIN PAGE
                  isCARSedanSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.car_repair_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarSedanCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarSedanPackagesSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Packages',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// FOR CAR SUV MAIN PAGE
                  isCARSuvSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.car_repair_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarSuvCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarSuvPackagesSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Packages',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// FOR CAR MPV MAIN PAGE
                  isCARMpvSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.car_repair_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarMpvCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isCarMpvPackagesSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Packages',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// FOR BIKE MAIN PAGE
                  isBikeSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons
                                                      .electric_bike_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isBikeCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isBikePackageSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Packages',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// FOR SANITIZATION MAIN PAGE
                  isSanitizationSelected
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        height: 235,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.sanitizer_outlined,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isSanitizationCategorySelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Space',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.settings,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isSanitizationPackageSelected =
                                                true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Services',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      child: Center(
                                        child: IconButton(
                                            icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback:
                                                    (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.blue,
                                                      Colors.greenAccent,
                                                    ],
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  size: 26,
                                                )),
                                            onPressed: () {
                                              setState(() {
                                                isDateTimeSelected = true;
                                              });
                                            }),
                                      ),
                                      radius: 30,
                                      backgroundColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24),
                              child: Divider(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22),
                              child: Text(
                                'Your Address:',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.70,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: addressController,
                                        autofocus: false,
                                        cursorColor: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        onSaved: (value) {
                                          SelectedInformation
                                              .customerAddress = value!;
                                        },
                                        validator: (value) {
                                          if (value == "") {
                                            return 'Address Is Compulsory';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary)),
                                  child: IconButton(
                                    icon: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          return ui.Gradient.linear(
                                            Offset(4.0, 24.0),
                                            Offset(24.0, 4.0),
                                            [
                                              Colors.blue,
                                              Colors.greenAccent,
                                            ],
                                          );
                                        },
                                        child: Icon(Icons
                                            .arrow_forward_ios_outlined)),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SelectedInformation.date =
                                            selectedDate
                                                .toString()
                                                .substring(0, 10);
                                        SelectedInformation.time =
                                            selectedTime
                                                .toString()
                                                .substring(10, 15);
                                        print(
                                            SelectedInformation.productID);
                                        print(SelectedInformation.date);
                                        print(
                                            SelectedInformation.categoryID);
                                        print(SelectedInformation
                                            .mainCategoryID);
                                        print(SelectedInformation.time);
                                        print(SelectedInformation
                                            .customerAddress);
                                        // var pref = await SharedPreferences
                                        //     .getInstance();
                                        // int currentCustomerId =
                                        //     pref.getInt('UserId');
                                        print(
                                            SelectedInformation.customerID);
                                        if (SelectedInformation
                                            .customerID ==
                                            null) {
                                          Navigator.of(context)
                                              .pushNamed(UserLogin.id);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              ConfirmationPage.id);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Theme
                                              .of(context)
                                              .colorScheme
                                              .background,
                                          content: Text(
                                            'Please Select All Information',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          duration:
                                          Duration(milliseconds: 1200),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  /// For Bike - Category page
                  isBikeCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons
                                                            .electric_bike_outlined,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isBikeCategorySelected = false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isBikeCategorySelected = false;
                                          isBikePackageSelected = true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isBikeCategorySelected = false;
                                          isBikePackageSelected = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Bike - Package page
                  isBikePackageSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .bike_scooter_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isBikePackageSelected = false;
                                            isBikeCategorySelected = true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isBikePackageSelected = false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isBikePackageSelected = false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Hactchback - Category page
                  isCarHatchbackCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons
                                                            .car_repair_outlined,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarHatchbackCategorySelected =
                                          false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarHatchbackCategorySelected =
                                          false;
                                          isCarHatchbackPackagesSelected =
                                          true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarHatchbackCategorySelected =
                                          false;
                                          isCarHatchbackPackagesSelected =
                                          true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Hatchback - Package page
                  isCarHatchbackPackagesSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .car_repair_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarHatchbackPackagesSelected =
                                            false;
                                            isCarHatchbackCategorySelected =
                                            true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarHatchbackPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarHatchbackPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Sedan - Category page
                  isCarSedanCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons
                                                            .car_repair_outlined,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSedanCategorySelected =
                                          false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSedanCategorySelected =
                                          false;
                                          isCarSedanPackagesSelected = true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSedanCategorySelected =
                                          false;
                                          isCarSedanPackagesSelected = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Sedan - Package page
                  isCarSedanPackagesSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .car_repair_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSedanPackagesSelected =
                                            false;
                                            isCarSedanCategorySelected =
                                            true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSedanPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSedanPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Suv - Category page
                  isCarSuvCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons
                                                            .car_repair_outlined,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSuvCategorySelected = false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSuvCategorySelected = false;
                                          isCarSuvPackagesSelected = true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarSuvCategorySelected = false;
                                          isCarSuvPackagesSelected = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Suv - Package page
                  isCarSuvPackagesSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .car_repair_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSuvPackagesSelected =
                                            false;
                                            isCarSuvCategorySelected = true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSuvPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarSuvPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Mpv - Category page
                  isCarMpvCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons
                                                            .car_repair_outlined,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarMpvCategorySelected = false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarMpvCategorySelected = false;
                                          isCarMpvPackagesSelected = true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCarMpvCategorySelected = false;
                                          isCarMpvPackagesSelected = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Car Mpv - Package page
                  isCarMpvPackagesSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .car_repair_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarMpvPackagesSelected =
                                            false;
                                            isCarMpvCategorySelected = true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarMpvPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCarMpvPackagesSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// For Sanitization - Category page
                  isSanitizationCategorySelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 275,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.3),
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          SelectedInformation.categoryID =
                                              Categories
                                                  .selectedCategories[index]
                                                  .categoryID;
                                          SelectedInformation.categoryName =
                                              Categories
                                                  .selectedCategories[index]
                                                  .name;
                                          print(Categories
                                              .selectedCategories[index]
                                              .isSelected);

                                          Products.fetchSelectedProducts(
                                              SelectedInformation
                                                  .categoryID);
                                          setState(() {
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected =
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected;
                                            print(Categories
                                                .selectedCategories[index]
                                                .isSelected);
                                            print(SelectedInformation
                                                .categoryID
                                                .toString());
                                            print(Categories
                                                .selectedCategories
                                                .length
                                                .toString() +
                                                "length");
                                            for (int i = 0;
                                            i <
                                                Categories
                                                    .selectedCategories
                                                    .length;
                                            i++) {
                                              Categories
                                                  .selectedCategories[i]
                                                  .isSelected = false;
                                            }
                                            Categories
                                                .selectedCategories[index]
                                                .isSelected = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                      Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .surface,
                                                      child: Icon(
                                                        Icons.sanitizer,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .secondary,
                                                      )),
                                                ),
                                                Categories
                                                    .selectedCategories[
                                                index]
                                                    .isSelected
                                                    ? Center(
                                                  child: Container(
                                                      child:
                                                      CircleAvatar(
                                                          radius:
                                                          40,
                                                          backgroundColor: Color
                                                              .fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .check,
                                                            size:
                                                            28,
                                                            color:
                                                            Colors.white,
                                                          ))),
                                                )
                                                    : Container()
                                              ],
                                              alignment: Alignment.center,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12,
                                                  vertical: 2),
                                              child: GradientText(
                                                text:
                                                '${Categories
                                                    .selectedCategories[index]
                                                    .name}',
                                                gradient:
                                                LinearGradient(
                                                    colors: [
                                                      Colors
                                                          .greenAccent,
                                                      Colors.blue,
                                                    ]),
                                                size: 16,
                                              ),
                                            )
                                                : Container(),
                                            !Categories
                                                .selectedCategories[
                                            index]
                                                .isSelected
                                                ? Text(
                                              '${Categories
                                                  .selectedCategories[index]
                                                  .name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .colorScheme
                                                      .onSurface),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: Categories
                                        .selectedCategories.length,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSanitizationCategorySelected =
                                          false;
                                        });
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
                                            horizontal: 24, vertical: 4),
                                        child: GradientText(
                                          text: 'Next',
                                          gradient: LinearGradient(colors: [
                                            Colors.greenAccent,
                                            Colors.blue,
                                          ]),
                                          size: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSanitizationCategorySelected =
                                          false;
                                          isSanitizationPackageSelected =
                                          true;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSanitizationCategorySelected =
                                          false;
                                          isSanitizationPackageSelected =
                                          true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                      : Container(),

                  /// For Sanitization - Package page
                  isSanitizationPackageSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.9),
                            borderRadius: new BorderRadius.circular(22),
                          ),
                          height: 375,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount:
                                      Products.selectedProducts.length,
                                      itemBuilder: (context, int index) {
                                        if (Products
                                            .selectedProducts.length ==
                                            0) {
                                          return Container(
                                              color: Colors.red,
                                              height: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Please Select Space First")));
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedProductID = Products
                                                //     .selectedProducts[index]
                                                //     .productID;
                                                SelectedInformation
                                                    .productID =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .productID;
                                                SelectedInformation
                                                    .productName =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .name;
                                                SelectedInformation
                                                    .productDescription =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .description;
                                                SelectedInformation
                                                    .productPrice =
                                                    Products
                                                        .selectedProducts[
                                                    index]
                                                        .discountPrice;

                                                Products
                                                    .selectedProducts[index]
                                                    .isSelected =
                                                !Products
                                                    .selectedProducts[
                                                index]
                                                    .isSelected;
                                                for (int i = 0;
                                                i <
                                                    Products
                                                        .selectedProducts
                                                        .length;
                                                i++) {
                                                  if (Products
                                                      .selectedProducts[
                                                  i]
                                                      .productID ==
                                                      SelectedInformation
                                                          .productID)
                                                    continue;
                                                  Products
                                                      .selectedProducts[i]
                                                      .isSelected = false;
                                                }
                                              });
                                              print(SelectedInformation
                                                  .productID);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Card(
                                                elevation: 1.5,
                                                shadowColor:
                                                Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .secondary,
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .background,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        leading:
                                                        CircleAvatar(
                                                          child: Center(
                                                            child:
                                                            ShaderMask(
                                                                blendMode:
                                                                BlendMode
                                                                    .srcIn,
                                                                shaderCallback:
                                                                    (Rect
                                                                bounds) {
                                                                  return ui
                                                                      .Gradient
                                                                      .linear(
                                                                    Offset(4.0,
                                                                        24.0),
                                                                    Offset(24.0,
                                                                        4.0),
                                                                    [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .greenAccent,
                                                                    ],
                                                                  );
                                                                },
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .sanitizer_outlined,
                                                                  size:
                                                                  28,
                                                                )),
                                                          ),
                                                          radius: 36,
                                                          backgroundColor:
                                                          Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .surface,
                                                        ),
                                                        title: Text(
                                                            '${Products
                                                                .selectedProducts[index]
                                                                .name}',
                                                            style: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18)),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .sellingPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              '${Products
                                                                  .selectedProducts[index]
                                                                  .discountPrice}',
                                                              style: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Products
                                                            .selectedProducts[
                                                        index]
                                                            .isSelected
                                                            ? Icon(
                                                          Icons
                                                              .radio_button_checked_outlined,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .colorScheme
                                                              .secondary,
                                                        )
                                                            : Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                        )),
                                                    ExpansionTile(
                                                      title: Center(
                                                        child: Text(
                                                          'View Details:-',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .colorScheme
                                                                  .secondary),
                                                        ),
                                                      ),
                                                      childrenPadding:
                                                      EdgeInsets.all(
                                                          10),
                                                      children: [
                                                        Text(
                                                          '${Products
                                                              .selectedProducts[index]
                                                              .description}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme
                                                                .of(
                                                                context)
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isSanitizationPackageSelected =
                                            false;
                                            isSanitizationCategorySelected =
                                            true;
                                          });
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
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 4),
                                          child: GradientText(
                                            text: 'Next',
                                            gradient:
                                            LinearGradient(colors: [
                                              Colors.greenAccent,
                                              Colors.blue,
                                            ]),
                                            size: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isSanitizationPackageSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isSanitizationPackageSelected =
                                            false;
                                            isDateTimeSelected = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                      : Container(),

                  /// FOR GENERAL DATE TIME PAGE
                  isDateTimeSelected
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.9),
                          borderRadius: new BorderRadius.circular(22),
                        ),
                        height: 325,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Choose Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 64),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                            // set border color
                                            width: 1.0), // set border width
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (val) {
                                        print(val);
                                      },
                                      validator: (value) {
                                        if (selectedDate == null)
                                          return "Enter Date";

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.all(5)),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Text(
                              //   'Choose Time',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w500,
                              //       fontSize: 18,
                              //       color: Theme.of(context)
                              //           .colorScheme
                              //           .onBackground),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     _selectTime(context);
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 64),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           border: Border.all(
                              //               color: Theme.of(context)
                              //                   .colorScheme
                              //                   .secondary,
                              //               width: 1.0), // set border width
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(32.0))),
                              //       child: TextFormField(
                              //         style: TextStyle(
                              //             fontSize: 24,
                              //             color: Theme.of(context)
                              //                 .colorScheme
                              //                 .onBackground),
                              //         textAlign: TextAlign.center,
                              //         onSaved: (String val) {
                              //           SelectedInformation.time = val;
                              //         },
                              //         validator: (value) {
                              //           if (selectedTime == null)
                              //             return "Enter Time";

                              //           return null;
                              //         },
                              //         enabled: false,
                              //         keyboardType: TextInputType.text,
                              //         controller: _timeController,
                              //         decoration: InputDecoration(
                              //             // labelText: 'Time',
                              //             contentPadding:
                              //                 EdgeInsets.all(5)),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24),
                                child: Divider(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onSurface,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24),
                                child: TextButton(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 24),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isDateTimeSelected = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }


}