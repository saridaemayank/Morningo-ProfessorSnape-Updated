import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morningo/Models/BottomNavBarController.dart';
import 'package:morningo/Models/user.dart';
import 'package:morningo/components/textfield_widget.dart';

void main() => runApp(AccountPage());

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User1 firebaseUser_;
  final user_firebase = FirebaseAuth.instance.currentUser;
  User result = FirebaseAuth.instance.currentUser;
  String email;
  String password;
  String name;
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: 'email');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final User firebaseUser = snapshot.data;
          if (firebaseUser != null) {
            firebaseUser_ = User1(
              firebaseUser.email,
              firebaseUser.email,
              firebaseUser.displayName,
            );
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  print(firebaseUser_.email);
                  Navigator.of(context).push(_createRoute());
                },
                child: Icon(
                  FeatherIcons.arrowLeft,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Account Page',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(user_firebase.photoURL),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFieldWidget(
                  label: 'Full Name',
                  text: firebaseUser.displayName,
                  onChanged: (displayName) {},
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  label: 'Email',
                  text: firebaseUser.email,
                  onChanged: (value) {
                    firebaseUser_.email = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  height: 70.0,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      print(controller.text);
                    },
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BottomNavController(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
