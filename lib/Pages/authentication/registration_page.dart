import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morningo/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../SetupPage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
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
          stream: FirebaseAuth.instance.authStateChanges(),
          key: _formKey,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   print(snapshot);
            //   return Center(child: CircularProgressIndicator());
            // } else if (snapshot.hasData) {
            //   print("snapshot has data");
            //   return SetupPage();
            // } else if (snapshot.hasError) {
            //   print("snapshot has error");
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetupPage(),
                              ),
                            );
                          }
                        },
                        label: Text(
                          'Sign Up With Google',
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
                      if (email == null) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } else if (password == null) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } else
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetupPage(),
                          ),
                        );

                      showSpinner = true;
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetupPage(),
                            ),
                          );
                        }

                        showSpinner = false;
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
                          'Sign Up',
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
