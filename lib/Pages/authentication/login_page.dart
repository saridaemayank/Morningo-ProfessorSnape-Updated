import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningo/Pages/SetupPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants.dart';
import '../../google_sign_in.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  User result = FirebaseAuth.instance.currentUser;
  bool showSpinner = false;
  String email;
  String password;

  final snackbar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.error_outline,
          size: 32,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            'Fill in all the fields',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,
  );
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          key: _formKey,
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);

            final User firebaseUser = snapshot.data;
            if (firebaseUser != null) print(firebaseUser.displayName);

            //TODO: fix the if statement
            if (snapshot.hasData) {
              return SetupPage();
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // } else if (snapshot.hasData) {
            //   return SetupPage();
            // } else if (snapshot.hasError) {
            //   return Center(
            //     child: Text('Something Went Wrong'),
            //   );
            // } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: 900,
                    child: Image.asset(
                      'Assets/Images/loginpage.png',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Welcome to Morningo',
                    style: TextStyle(
                      fontFamily: 'Caviar Dreams',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Welcome User!',
                    style: TextStyle(
                      fontFamily: 'Caviar Dreams',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade300,
                          onPrimary: Colors.black,
                          elevation: 0.0,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                          if (GoogleSignInProvider().getUser() != null) {
                            print(GoogleSignInProvider().getUser());

                            print(snapshot);
                            Navigator.pushNamed(context, 'setup');
                          }
                        },
                        label: Text(
                          'Sign In With Google',
                          style: TextStyle(
                            fontFamily: 'Caviar Dreams',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            ),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 330.0, bottom: 10.0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 310.0, bottom: 10.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                    child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (email == null || password == null) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      height: 65.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Caviar Dreams',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
