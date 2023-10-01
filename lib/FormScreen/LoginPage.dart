import 'package:carwash/Widgets/widget.dart';
import '../Screen/screens.dart';
import 'package:carwash/Model/Model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  static String id = "UserLogin";

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late String email, password;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Customers.getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                  child: Center(
                    child: Card(
                      shadowColor: Theme.of(context).colorScheme.secondary,
                      color: Theme.of(context).colorScheme.background,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 28),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Login Here',
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),

                              /// TextField for Email
                              CustomTextField(
                                label: "Email",
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                onSave: (value) {
                                  setState(() {
                                    email = value!;
                                  });
                                },
                                onValidate: (value) {
                                  if (!value!.contains("@")) {
                                    return 'Email Must Be Valid';
                                  }
                                  return null;
                                },
                                isObscure: false,
                              ),
                              SizedBox(
                                height: 16,
                              ),

                              /// TextField for Password
                              CustomTextField(
                                  label: "Password",
                                  keyboardType: TextInputType.text,
                                  onSave: (value) {
                                    setState(() {
                                      password = value!;
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
                                height: 32,
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
                                        horizontal: 48, vertical: 12),
                                    child: GradientText(
                                      text: 'Login',
                                      gradient: LinearGradient(colors: [
                                        Colors.greenAccent,
                                        Colors.blue,
                                      ]),
                                      size: 18,
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        int i;

                                        /// to authenticate customer that customer is present or not
                                        for (i = 0;
                                            i < Customers.customers.length;
                                            i++) {
                                          if (email ==
                                                  Customers
                                                      .customers[i].email &&
                                              password ==
                                                  Customers
                                                      .customers[i].password) {
                                            print('in if condition');

                                            /// storing customer information into sessions
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();

                                            pref.setString('email', email);
                                            print(
                                                'after shared pref condition');
                                            print(email);
                                            print(Customers.customers[i].id);
                                            print(Customers.customers[i].name);
                                            print(Customers
                                                .customers[i].phoneNumber);
                                            pref.setString(
                                                'name',
                                                Customers.customers[i].name ??
                                                    '');
                                            pref.setInt('UserId', Customers.customers[i].id as int);

                                            pref.setString(
                                                'phoneNumber',
                                                Customers.customers[i]
                                                        .phoneNumber ??
                                                    '');

                                            SelectedInformation.customerEmail =
                                                email;
                                            SelectedInformation.customerID =
                                                Customers.customers[i].id;
                                            SelectedInformation.customerName =
                                                Customers.customers[i].name;
                                            SelectedInformation
                                                .customerPhoneNumber = Customers
                                                    .customers[i].phoneNumber ??
                                                '';
                                            print(SelectedInformation
                                                .isLoginFromHome);
                                            if (SelectedInformation
                                                    .isLoginFromHome ??
                                                false) {
                                              SelectedInformation
                                                  .isLoginFromHome = false;
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      HomePage.id);
                                            } else {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      ConfirmationPage.id);
                                            }
                                            break;
                                          }
                                        }

                                        /// if customer is not valid
                                        /// entered email and password are valid but no customer exist with that credentials
                                        if (i == Customers.customers.length) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'No User with This Credentials'),
                                            duration: Duration(seconds: 2),
                                          ));
                                        }
                                      } else {
                                        /// entered email and password are not valid
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Please Enter Correct Credentials'),
                                          duration: Duration(seconds: 2),
                                        ));
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }),
                              SizedBox(
                                height: 54,
                              ),

                              /// for registering the customer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(UserRegister.id);
                                    },
                                    child: Text(
                                      'Register Here',
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
    );
  }
}
