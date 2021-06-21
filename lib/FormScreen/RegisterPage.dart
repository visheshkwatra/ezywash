import 'package:carwash/Model/Model.dart';
import 'package:carwash/Widgets/widget.dart';
import 'package:carwash/FormScreen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carwash/Screen/screens.dart';

class UserRegister extends StatefulWidget {
  static String id = "RegisterLogin";

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String name, email, phoneNumber, password;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  int userID;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: LoadingOverlay(
          color: Theme.of(context).colorScheme.secondary,
          isLoading: isLoading,
          child: Scaffold(
            body: Container(
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  /// EzyWash Logo
                  EzyWashLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Card(
                        shadowColor: Theme.of(context).colorScheme.secondary,
                        color: Theme.of(context).colorScheme.background,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 18),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Register Here',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Divider(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomTextField(
                                    label: "Full Name",
                                    icon: Icons.supervised_user_circle_outlined,
                                    onSave: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    onValidate: (value) {
                                      if (value == "") {
                                        return 'Full Name is compulsory';
                                      }
                                      return null;
                                    },
                                    isObscure: false,
                                    keyboardType: TextInputType.name),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  label: "Email",
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  onSave: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  onValidate: (value) {
                                    if (!value.contains("@")) {
                                      return 'Email Must Be Valid';
                                    }
                                    return null;
                                  },
                                  isObscure: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  label: "Phone Number",
                                  onSave: (value) {
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                  },
                                  onValidate: (value) {
                                    if (value.length != 10) {
                                      return 'Phone Number must be of 10 Digit';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  icon: Icons.phone_outlined,
                                  isObscure: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                    label: "Password",
                                    keyboardType: TextInputType.text,
                                    onSave: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    onValidate: (value) {
                                      if (value == "") {
                                        return "Password is compulsory";
                                      }
                                      return null;
                                    },
                                    isObscure: true,
                                    icon: Icons.security_outlined),
                                SizedBox(
                                  height: 24,
                                ),
                                Center(
                                  child: UnicornOutlineButton(
                                    strokeWidth: 2,
                                    radius: 24,
                                    gradient: LinearGradient(colors: [
                                      Colors.blue,
                                      Colors.greenAccent,
                                    ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 48, vertical: 12),
                                      child: GradientText(
                                        text: 'Register',
                                        gradient: LinearGradient(colors: [
                                          Colors.greenAccent,
                                          Colors.blue,
                                        ]),
                                        size: 18,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (Customers.isCustomerUnique(email)) {
                                          /// If Customer Does Not Exist means Unique
                                          print('email: $email');
                                          print('password : $password');
                                          print('name: $name');
                                          print('phoneNumber : $phoneNumber');
                                          SelectedInformation.customerName =
                                              name;

                                          SelectedInformation.customerEmail =
                                              email;

                                          SelectedInformation
                                                  .customerPhoneNumber =
                                              phoneNumber;

                                          Customers.postCustomers(Customers(
                                              name: name,
                                              email: email,
                                              password: password,
                                              phoneNumber: phoneNumber));
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          pref.setString('email', email);
                                          pref.setString('name', name);
                                          pref.setString('phone', phoneNumber);
                                          print(pref.getString('email'));

                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return UserLogin();
                                            }),
                                            ModalRoute.withName(HomePage.id),
                                          );
                                        } else {
                                          /// If Customer is already exist
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('User Already Exist'),
                                            duration: Duration(seconds: 2),
                                          ));
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already, Have an account?',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UserLogin();
                                        }));
                                      },
                                      child: Text(
                                        'Login now',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
